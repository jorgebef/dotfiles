#!/bin/bash

session="$(tmux display -p "_popup_$1_#S")"

if ! tmux has -t "$session" 2> /dev/null; then
  parent_session="$(tmux display -p '#{session_id}')"
  session_id="$(tmux new-session -c '#{pane_current_path}' -dP -s "$session" -F '#{session_id}' -e TMUX_PARENT_SESSION="$parent_session" -e TMUX_POPUP_SESSION="$session")"
  exec tmux set-option -t "$session_id" key-table popup \; \
    set-option -t "$session_id" status off \; \
    set-option -t "$session_id" prefix C-b \; \
    set-option -t "$session_id" detach-on-destroy on \; \
    attach -t "$session"
fi

exec tmux attach -t "$session" > /dev/null

