#!/usr/bin/env bash
# alias: 'n/a'
# desc: shared libraries.
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

fn_get_env() {
  tmux showenv -g "$1" | cut -d '=' -f 2-
}

fn_get_final_opt() {
  local option_value
  option_value="$(tmux show-option -gqv "$1")"
  [ -z "$option_value" ] && option_value="$2"
  echo "$option_value"
}

DEFAULT_TITLE=''
DEFAULT_SESSION_NAME='tmux-float-term-session'
TMUX_FLOAT_TERM_WIDTH=$(fn_get_env TMUX_FLOAT_TERM_WIDTH)
TMUX_FLOAT_TERM_HEIGHT=$(fn_get_env TMUX_FLOAT_TERM_HEIGHT)
TMUX_FLOAT_TERM_BORDER_COLOR=$(fn_get_env TMUX_FLOAT_TERM_BORDER_COLOR)
TMUX_FLOAT_TERM_TEXT_COLOR=$(fn_get_env TMUX_FLOAT_TERM_TEXT_COLOR)
TMUX_FLOAT_TERM_CHANGE_PATH=$(fn_get_env TMUX_FLOAT_TERM_CHANGE_PATH)
TMUX_FLOAT_TERM_TITLE=$(fn_get_env TMUX_FLOAT_TERM_TITLE)
TMUX_FLOAT_TERM_SESSION_NAME=$(fn_get_env TMUX_FLOAT_TERM_SESSION_NAME)

fn_get_tmux_version() {
  tmux -V | cut -d ' ' -f 2
}

fn_change_popup_title() {
  tmux setenv -g TMUX_FLOAT_TERM_TITLE "$1"
  tmux_popup
}

# checks whether tmux version is >= 3.3
fn_is_tmux_version_supported() {
  local version
  IFS='.' read -r -a version < <(fn_get_tmux_version)

  [ "${version[0]}" -gt 3 ] && return 0

  # minor version can be a number or alphanumeric, e.g. 3.3 vs 3.3a
  [ "${version[0]}" -eq 3 ] && [ "${version[1]//[!0-9]}" -ge 3 ] && return 0

  return 1
}

fn_tmux_popup() {
  if fn_is_tmux_version_supported; then
    if ! fn_do_tmux_pop; then
      tmux setenv -g TMUX_FLOAT_TERM_WIDTH "$(fn_get_final_opt '@tmux-float-term-width' '80%')" 
      tmux setenv -g TMUX_FLOAT_TERM_HEIGHT "$(fn_get_final_opt '@tmux-float-term-height' '80%')"
      fn_do_tmux_pop
    fi
  else
    tmux display-message \
      -d 2000 \
      "requires tmux version 3.3 or newer"
  fi
}

fn_do_tmux_pop() {
  TMUX_FLOAT_TERM_WIDTH=$(fn_get_env TMUX_FLOAT_TERM_WIDTH)
  TMUX_FLOAT_TERM_HEIGHT=$(fn_get_env TMUX_FLOAT_TERM_HEIGHT)

  TMUX_FLOAT_TERM_TITLE=$(fn_get_env TMUX_FLOAT_TERM_TITLE)
  [ -z "${TMUX_FLOAT_TERM_TITLE}" ] && TMUX_FLOAT_TERM_TITLE="${DEFAULT_TITLE}"

  TMUX_FLOAT_TERM_SESSION_NAME=$(fn_get_env TMUX_FLOAT_TERM_SESSION_NAME)
  [ -z "${TMUX_FLOAT_TERM_SESSION_NAME}" ] && TMUX_FLOAT_TERM_SESSION_NAME="${DEFAULT_SESSION_NAME}"

  tmux set-option -t "${TMUX_FLOAT_TERM_SESSION_NAME}" detach-on-destroy on

  tmux popup \
    -b rounded \
    -T "${TMUX_FLOAT_TERM_TITLE}" \
    -w "${TMUX_FLOAT_TERM_WIDTH}" \
    -h "${TMUX_FLOAT_TERM_HEIGHT}" \
    -S fg="${TMUX_FLOAT_TERM_BORDER_COLOR}" \
    -s fg="${TMUX_FLOAT_TERM_TEXT_COLOR}" \
    -E \
    "tmux attach-session -t \"${TMUX_FLOAT_TERM_SESSION_NAME}\""
}
