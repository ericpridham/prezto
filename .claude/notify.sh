#!/bin/bash
result=$(alerter --title 'Claude Code' --message "$1" --sender com.jetbrains.PhpStorm --sound default --json 2>/dev/null)
activation=$(echo "$result" | grep -o '"activationType" *: *"[^"]*"' | cut -d'"' -f4)
if [ "$activation" = "contentsClicked" ] || [ "$activation" = "actionClicked" ]; then
    open -a PhpStorm
fi
