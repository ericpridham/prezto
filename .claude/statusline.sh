#!/usr/bin/env bash
set -euo pipefail

input=$(cat)
model=$(echo "$input" | jq -r '.model.display_name')
project=$(echo "$input" | jq -r '.workspace.project_dir' | xargs basename)

# Context window (tokens used in K)
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$used_pct" ]; then
  used_int=$(printf "%.0f" "$used_pct")
  used_k=$(printf "%.0f" "$(echo "$used_pct * 200 / 100" | bc -l)")
else
  used_int=0
  used_k=0
fi

meter="${used_k}K"

if [ "$used_int" -lt 50 ]; then
  color="\033[1;32m"
elif [ "$used_int" -le 75 ]; then
  color="\033[1;33m"
else
  color="\033[1;31m"
fi

bar_length=10

# Claude usage meter (extra usage monthly)
claude_pct=""
usage_json=$("$HOME/bin/claude-usage" 2>/dev/null) || true
if [ -n "$usage_json" ]; then
  claude_pct=$(echo "$usage_json" | jq -r '.extra_usage.utilization // empty')
fi

if [ -n "$claude_pct" ]; then
  claude_int=$(printf "%.0f" "$claude_pct")
  filled=$((claude_int * bar_length / 100))
  claude_bar="["
  for ((i = 0; i < filled; i++)); do claude_bar+="█"; done
  for ((i = filled; i < bar_length; i++)); do claude_bar+="░"; done
  # Cache age from claude-usage JSON
  age_s=$(echo "$usage_json" | jq -r '.cache_age_seconds // 0')
  cache_age=""
  if [ "$age_s" -lt 60 ]; then
    cache_age=" ${age_s}s"
  else
    cache_age=" $(( age_s / 60 ))m"
  fi

  claude_bar+="] ${claude_int}%"$'\033'"[0;37m${cache_age}"$'\033'"[0m"

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
