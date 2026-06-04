#!/usr/bin/env bash
# Print GitHub Copilot premium-request usage as "<used>/<entitlement>".
# Visible only while `opencode` runs somewhere in the current tmux server.
# Silent (empty output) on any failure so the status bar never breaks.

# -e  exit immediately if any command returns non-zero
# -u  treat unset variables as errors (catches typos like $TMDI)
# -o pipefail  without this, "cmd1 | cmd2" succeeds even if cmd1 fails;
#              with it, the pipe's exit code is the first failure's code
set -euo pipefail

# $TMUX is set by tmux itself in every pane it spawns.
# -n = non-empty string. If we're not inside tmux, there's no
# `tmux list-panes` to call and no status bar to feed — bail early.
[[ -n ${TMUX-} ]] || exit 0

# `command -v` checks if a program exists in PATH without running it.
# && chains: if gh is missing OR jq is missing, exit silently.
command -v gh >/dev/null && command -v jq >/dev/null || exit 0
command -v tmux >/dev/null || exit 0

# list-panes -a = all panes across all windows/sessions in this server.
# -F '#{pane_current_command}' = print only the foreground process name.
# grep -qx = quiet (-q, no output) + exact full-line match (-x).
# If no pane is running opencode, nothing to show — exit silently.
tmux list-panes -a -F '#{pane_current_command}' 2>/dev/null \
  | grep -qx opencode || exit 0

# TTL (time-to-live): how many seconds the cached result is considered fresh.
# The gh API call costs a network round-trip; the status bar refreshes every
# 15s. Without a cache we'd hammer the API ~4×/min. With ttl=60 we call
# at most once per minute, and only while opencode is alive.
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
# || exit 0 at the end means: if the whole pipeline fails for any reason,
# exit silently rather than printing an error into the status bar.
out=$(gh api /copilot_internal/user 2>/dev/null \
  | jq -r '.quota_snapshots.premium_interactions
      | if .unlimited then "∞"
        else "\((.entitlement - .remaining) | floor)/\(.entitlement)"
        end
     ' 2>/dev/null) || exit 0

# Guard: jq can output the literal string "null" if the key was missing.
# -n = non-empty, != null = not the jq null-as-string sentinel.
[[ -n $out && $out != null ]] || exit 0

# tee writes to both stdout (consumed by tmux's #(...) expansion) and
# the cache file simultaneously, so a single call does both jobs.
# The leading space pads the text away from the pill's middle separator.
printf ' %s' "$out" | tee "$cache"
