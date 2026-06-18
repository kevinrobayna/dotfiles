#!/bin/bash
input=$(cat)
MODEL=$(echo "$input" | jq -r '.model.display_name')
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
printf "[%s] 💰 \$%.2f | 📊 %s%% ctx\n" "$MODEL" "$COST" "$PCT"
