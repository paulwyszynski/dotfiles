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
