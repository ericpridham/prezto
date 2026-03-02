#!/usr/bin/env bash
set -euo pipefail

input=$(cat)
model=$(echo "$input" | jq -r '.model.display_name')
project=$(echo "$input" | jq -r '.workspace.project_dir' | xargs basename)

# Context window meter
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$used" ]; then
  used_int=$(printf "%.0f" "$used")
else
  used_int=0
fi

bar_length=10
filled=$((used_int * bar_length / 100))
meter="["
for ((i = 0; i < filled; i++)); do meter+="█"; done
for ((i = filled; i < bar_length; i++)); do meter+="░"; done
meter+="] ${used_int}%"
meter="🪟  ${meter}"

if [ "$used_int" -lt 50 ]; then
  color="\033[1;32m"
elif [ "$used_int" -le 75 ]; then
  color="\033[1;33m"
else
  color="\033[1;31m"
fi

# Claude usage meter (5-hour window)
claude_pct=""
usage_json=$(claude-usage 2>/dev/null) || true
if [ -n "$usage_json" ]; then
  claude_pct=$(echo "$usage_json" | jq -r '.five_hour.utilization // empty')
fi

if [ -n "$claude_pct" ]; then
  claude_int=$(printf "%.0f" "$claude_pct")
  filled=$((claude_int * bar_length / 100))
  claude_bar="["
  for ((i = 0; i < filled; i++)); do claude_bar+="█"; done
  for ((i = filled; i < bar_length; i++)); do claude_bar+="░"; done
  claude_bar+="] ${claude_int}%"
  claude_bar="⏱️  ${claude_bar}"

  if [ "$claude_int" -lt 50 ]; then
    claude_color="\033[1;32m"
  elif [ "$claude_int" -le 75 ]; then
    claude_color="\033[1;33m"
  else
    claude_color="\033[1;31m"
  fi

  printf "\033[1;34m%s\033[0m │ \033[1;36m%s\033[0m │ %b%s\033[0m │ %b%s\033[0m" \
    "$model" "$project" "$color" "$meter" "$claude_color" "$claude_bar"
else
  printf "\033[1;34m%s\033[0m │ \033[1;36m%s\033[0m │ %b%s\033[0m" \
    "$model" "$project" "$color" "$meter"
fi
