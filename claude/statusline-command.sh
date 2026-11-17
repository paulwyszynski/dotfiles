#!/bin/bash
# Claude Code statusLine
# Styled to match the user's oh-my-posh "catppuccin" prompt theme
# (~/.config/oh-my-posh/catppuccin.omp.toml)

input=$(cat)

# Catppuccin palette colors used by the oh-my-posh theme (truecolor ANSI)
PINK='\033[38;2;245;189;230m'     # #F5BDE6 - path segment
LAVENDER='\033[38;2;183;189;248m' # #B7BDF8 - git segment
BLUE='\033[38;2;138;173;244m'     # #8AADF4 - time segment
TEAL='\033[38;2;139;213;202m'     # #8BD5CA - context bar segment
TEXT='\033[38;2;73;77;100m'       # #494D64 - secondary text
RESET='\033[0m'

cwd=$(echo "$input" | jq -r '.workspace.current_dir')
dir_display="${cwd/#$HOME/~}"
model=$(echo "$input" | jq -r '.model.display_name')

# Context window usage as a progress bar
context_segment=""
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$used_pct" ]; then
  pct=$(printf '%.0f' "$used_pct")
  [ "$pct" -lt 0 ] && pct=0
  [ "$pct" -gt 100 ] && pct=100
  bar_width=10
  filled=$(( (pct * bar_width + 50) / 100 ))
  [ "$filled" -gt "$bar_width" ] && filled=$bar_width
  empty=$(( bar_width - filled ))
  filled_bar=$(printf '%*s' "$filled" '' | tr ' ' '█')
  empty_bar=$(printf '%*s' "$empty" '' | tr ' ' '░')
  context_segment=$(printf "${TEAL} [%s%s] %d%%${RESET}" "$filled_bar" "$empty_bar" "$pct")
fi

# Usage limit (5-hour window) as a progress bar, appended to the context segment.
# rate_limits is only sent for Claude.ai subscribers after the first API response.
PEACH='\033[38;2;245;169;127m' # #F5A97F - usage limit bar
limit_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
if [ -n "$limit_pct" ]; then
  lpct=$(printf '%.0f' "$limit_pct")
  [ "$lpct" -lt 0 ] && lpct=0
  [ "$lpct" -gt 100 ] && lpct=100
  lfilled=$(( (lpct * 10 + 50) / 100 ))
  lempty=$(( 10 - lfilled ))
  lfilled_bar=$(printf '%*s' "$lfilled" '' | tr ' ' '█')
  lempty_bar=$(printf '%*s' "$lempty" '' | tr ' ' '░')
  reset_txt=""
  resets_at=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
  if [ -n "$resets_at" ]; then
    reset_fmt=$(date -r "${resets_at%.*}" "+%-I:%M%p" 2>/dev/null)
    [ -n "$reset_fmt" ] && reset_txt=" resets $reset_fmt"
  fi
  context_segment="$context_segment$(printf "${PEACH} 5h [%s%s] %d%%%s${RESET}" "$lfilled_bar" "$lempty_bar" "$lpct" "$reset_txt")"
fi

# Weekly usage limit (7-day window) as a progress bar, placed after the 5-hour bar.
MAUVE='\033[38;2;198;160;246m' # #C6A0F6 - weekly limit bar
week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
if [ -n "$week_pct" ]; then
  wpct=$(printf '%.0f' "$week_pct")
  [ "$wpct" -lt 0 ] && wpct=0
  [ "$wpct" -gt 100 ] && wpct=100
  wfilled=$(( (wpct * 10 + 50) / 100 ))
  wempty=$(( 10 - wfilled ))
  wfilled_bar=$(printf '%*s' "$wfilled" '' | tr ' ' '█')
  wempty_bar=$(printf '%*s' "$wempty" '' | tr ' ' '░')
  wreset_txt=""
  wresets_at=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')
  if [ -n "$wresets_at" ]; then
    wreset_fmt=$(date -r "${wresets_at%.*}" "+%a %-I:%M%p" 2>/dev/null)
    [ -n "$wreset_fmt" ] && wreset_txt=" resets $wreset_fmt"
  fi
  context_segment="$context_segment$(printf "${MAUVE} 7d [%s%s] %d%%%s${RESET}" "$wfilled_bar" "$wempty_bar" "$wpct" "$wreset_txt")"
fi

# Git branch + working tree status (skip optional locks to avoid contention)
git_segment=""
if git -C "$cwd" --no-optional-locks rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)
  if [ -n "$branch" ]; then
    dirty=""
    if [ -n "$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)" ]; then
      dirty=" *"
    fi
    git_segment=$(printf "  ${LAVENDER} %s%s${RESET}" "$branch" "$dirty")
  fi
fi

time_str=$(date "+%-I:%M%p")

printf "${TEXT}%s${RESET}%s  ${PINK} %s${RESET}%s  ${BLUE} %s${RESET}\n" "$model" "$context_segment" "$dir_display" "$git_segment" "$time_str"
