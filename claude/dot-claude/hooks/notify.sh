#!/usr/bin/env bash
set -euo pipefail

# Notification hook: focuses the tmux or Rex pane running Claude Code so the
# user lands right back in it. Alerts come from Bartender's Top Shelf.

LOG="/tmp/claude-notify-hook.log"

log() {
  echo "[$(date '+%H:%M:%S')] $*" >> "$LOG"
}

log "Hook triggered"

if [[ -n "${TMUX:-}" ]]; then
  session=$(tmux display-message -p '#S')
  log "Focusing tmux session: $session, pane: ${TMUX_PANE:-unknown}"

  tmux switch-client -t "$session" 2>/dev/null || true
  tmux select-window -t "$TMUX_PANE" 2>/dev/null || true
  tmux select-pane   -t "$TMUX_PANE" 2>/dev/null || true
elif [[ -n "${REX_SESSION:-}" && -n "${REX_BLOCK:-}" ]]; then
  if ! command -v rex >/dev/null 2>&1; then
    log "rex not on PATH, skipping focus"
    exit 0
  fi
  log "Focusing Rex session: $REX_SESSION, block: $REX_BLOCK"

  # Select the tab and pane inside the session, then have this Mac's app
  # (its client label is the hostname) show the session. The app step needs
  # Remote Control enabled in Rex.
  rex --timeout 2s focus -s "$REX_SESSION" "$REX_BLOCK" >/dev/null 2>&1 \
    || log "rex focus failed"
  rex --timeout 2s -C "$(hostname -s)" "do" session.select session_id="$REX_SESSION" >/dev/null 2>&1 \
    || log "rex session.select failed"
else
  log "Not in tmux or Rex, skipping focus"
fi
