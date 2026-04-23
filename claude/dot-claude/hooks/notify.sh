#!/usr/bin/env bash
set -euo pipefail

# Notification hook: focuses the tmux pane running Claude Code and
# sends a macOS notification so the user knows Claude needs attention.

LOG="/tmp/claude-notify-hook.log"

log() {
  echo "[$(date '+%H:%M:%S')] $*" >> "$LOG"
}

log "Hook triggered"

# --- tmux focus ---
# If we're inside tmux, bring the correct session/window/pane to the front
# so the user lands right back in the Claude Code pane.
if [[ -n "${TMUX:-}" ]]; then
  session=$(tmux display-message -p '#S')
  log "Focusing tmux session: $session, pane: ${TMUX_PANE:-unknown}"

  tmux switch-client -t "$session" 2>/dev/null || true
  tmux select-window -t "$TMUX_PANE" 2>/dev/null || true
  tmux select-pane   -t "$TMUX_PANE" 2>/dev/null || true
else
  log "Not in tmux, skipping focus"
fi

# --- macOS notification ---
project=$(basename "$PWD")
log "Sending notification for project: $project"

osascript -e "display notification \"Claude needs your attention\" with title \"Claude Code - $project\""

log "Notification sent"
