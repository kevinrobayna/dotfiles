#!/usr/bin/env bash
set -euo pipefail

# PostToolUse hook: opens a tmux split showing the plan file when Claude creates/edits one.

LOG="/tmp/claude-plan-hook.log"

log() {
  echo "[$(date '+%H:%M:%S')] $*" >> "$LOG"
}

log "Hook triggered"

# Must be in tmux
if [[ -z "${TMUX:-}" ]]; then
  log "Not in tmux, exiting"
  exit 0
fi

# Read hook JSON from stdin
input=$(cat)
log "Input received (tool: $(echo "$input" | jq -r '.tool_name // "unknown"'))"

# Extract file path from tool_input
file_path=$(echo "$input" | jq -r '.tool_input.file_path // .tool_input.filePath // .tool_input.path // ""')
log "Extracted file_path: $file_path"

[[ -z "$file_path" ]] && { log "Empty file_path, exiting"; exit 0; }

# Only trigger for plan files
[[ "$file_path" != */.claude/plans/*.md ]] && { log "Not a plan file: $file_path"; exit 0; }
[[ ! -f "$file_path" ]] && { log "File does not exist: $file_path"; exit 0; }

log "Plan file detected: $file_path"

# Check if a pane is already showing this plan file (avoid duplicates)
plan_basename=$(basename "$file_path")
if tmux list-panes -t "${TMUX_PANE}" -F '#{pane_pid}' 2>/dev/null | while read pid; do
  ps -o command= -p "$pid" 2>/dev/null
done | grep -q "plan-viewer.*$plan_basename"; then
  log "Pane already exists for $plan_basename, exiting"
  exit 0
fi

viewer="bash -c 'clear; glow -w 0 \"$file_path\"; fswatch -o \"$file_path\" | while read; do clear; glow -w 0 \"$file_path\"; done'"

log "Opening split targeting pane: ${TMUX_PANE:-default}"

# Open a vertical split (30% width, on the right) targeting the current pane
tmux split-window -h -l '30%' -t "${TMUX_PANE}" "$viewer"

# Return focus to the original pane (Claude Code's pane)
tmux select-pane -t "${TMUX_PANE}"

log "Split opened successfully"
