#!/usr/bin/env bash
# alias: 'n/a'
# desc: plugin entry point.
# usage: fn_main.sh [args]
# flags: @WIP:0 @TODO:0 @FIXME:0 @BUG:0 @OPTIMIZE:0 @REFACTOR:0 @DEPRECATED:0

declare -r _self_path_file_=$(readlink -f "$0")
declare -r _self_path_dir_=$(dirname "${_self_path_file_}")
# echo [DEBUG] _self_path_dir_: "${_self_path_dir_}"

# check if script run directly or indirect
# if [ "${0}" = "${BASH_SOURCE}" ]; then
#   echo "Script is being run directly"
# else
#   echo "Script is being sourced"
# fi

fn_main() {
  source "${_self_path_dir_}/libs.sh"

  tmux setenv -g ORIGIN_SESSION "$(tmux display -p '#{session_name}')"

  if [ "$(tmux display-message -p '#{session_name}')" = "${TMUX_FLOAT_TERM_SESSION_NAME}" ]; then
    if [ -z "${TMUX_FLOAT_TERM_TITLE}" ]; then
      TMUX_FLOAT_TERM_TITLE=''
    fi

    if [ -z "${TMUX_FLOAT_TERM_SESSION_NAME}" ]; then
      TMUX_FLOAT_TERM_SESSION_NAME="$DEFAULT_SESSION_NAME"
    fi

    fn_change_popup_title "${TMUX_FLOAT_TERM_TITLE}"
    tmux setenv -g TMUX_FLOAT_TERM_TITLE "${TMUX_FLOAT_TERM_TITLE}"
    tmux detach-client
  else
    # is the floating session exists
    if tmux has-session -t "${TMUX_FLOAT_TERM_SESSION_NAME}" 2>/dev/null; then
      fn_tmux_popup
    else
      # create a new special session and attach to it
      tmux new-session -d -c "$(tmux display-message -p '#{pane_current_path}')" -s "${TMUX_FLOAT_TERM_SESSION_NAME}"
      tmux set-option -t "${TMUX_FLOAT_TERM_SESSION_NAME}" status off
      fn_tmux_popup
    fi
  fi
}

fn_main "$@"
