#!/usr/bin/env bash
# Print GitHub Copilot premium-request usage as "<used>/<entitlement>".
# Visible while BOTH hold:
#   1. an opencode process is running on this machine (any tmux session,
#      popup, or even outside tmux),
#   2. `gh` is authenticated (logged out -> API fails -> silent exit).
# Silent (empty output) on any failure so the status bar never breaks.

# -e  exit immediately if any command returns non-zero
# -u  treat unset variables as errors (catches typos like $TMDI)
# -o pipefail  without this, "cmd1 | cmd2" succeeds even if cmd1 fails;
#              with it, the pipe's exit code is the first failure's code
set -euo pipefail

# tmux servers spawned with a bare environment (launchd, remote Linux) may
# lack Homebrew dirs in PATH. Prepend common locations; missing dirs are a
# harmless no-op and existing PATH entries keep priority elsewhere.
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

# `command -v` checks if a program exists in PATH without running it.
# && chains: if gh is missing OR jq is missing, exit silently.
command -v gh >/dev/null && command -v jq >/dev/null || exit 0

# Gate: only show the chip while an opencode process runs somewhere on this
# machine (any tmux session, popup, or outside tmux). ucomm= prints the real
# process name: "opencode.exe" on macOS (bun-compiled binary), "opencode" on
# Linux — the ^opencode prefix covers both. Don't use pgrep here: macOS pgrep
# can't see this process at all (missing from its sysctl enumeration), and
# tmux's pane_current_command misses popups entirely.
# Note: runs BEFORE the cache check so the chip vanishes on the next 15s
# refresh after opencode exits; the cache is kept so a restart shows instantly.
ps -axo ucomm= 2>/dev/null | grep -q '^opencode' || exit 0

# TTL (time-to-live): how many seconds the cached result is considered fresh.
# The gh API call costs a network round-trip; the status bar refreshes every
# 15s. Without a cache we'd hammer the API ~4×/min. With ttl=60 we call
# at most once per minute. Failures cache an empty result so a logged-out
# machine also stays at one attempt per minute.
cache="${TMPDIR:-/tmp}/copilot-ai-usage.${UID:-$(id -u)}"
ttl=60

# stat prints a file's last-modified time as a Unix timestamp (seconds since
# 1970-01-01). macOS stat uses -f %m; Linux stat uses -c %Y. The 2>/dev/null
# suppresses errors; || provides the Linux fallback if the macOS form fails.
mtime() { stat -f %m "$1" 2>/dev/null || stat -c %Y "$1"; }

# (( ... )) is bash arithmetic. If cache file exists AND its age is under ttl,
# print cached result and exit — skipping the network call entirely.
if [[ -f $cache ]] && (( $(date +%s) - $(mtime "$cache") < ttl )); then
  cat "$cache"
  exit 0
fi

# gh api calls the GitHub REST API using your stored auth token.
# The result is piped to jq which parses the JSON.
# 2>/dev/null silences any error output (network down, auth expired, etc.).
# On any failure (incl. logged out): cache the empty result so we don't
# retry on every 15s status refresh, then exit silently.
out=$(gh api /copilot_internal/user 2>/dev/null \
  | jq -r '.quota_snapshots.premium_interactions
      | if .unlimited then "∞"
        else "\((.entitlement - .remaining) | floor)/\(.entitlement)"
        end
     ' 2>/dev/null) || { : > "$cache"; exit 0; }

# Guard: jq can output the literal string "null" if the key was missing.
# -n = non-empty, != null = not the jq null-as-string sentinel.
[[ -n $out && $out != null ]] || { : > "$cache"; exit 0; }

# tee writes to both stdout (consumed by tmux's #(...) expansion) and
# the cache file simultaneously, so a single call does both jobs.
# The leading space pads the text away from the pill's middle separator.
printf ' %s' "$out" | tee "$cache"
