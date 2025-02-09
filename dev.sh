#!/usr/bin/env bash
# alias: 'n/a'
# desc: run the plugin in dev mode.
# usage: fn_dev.sh
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

fn_dev() {
  # if --start
  if [ "$1" = "--start" ]; then
    tmux run-shell "${_self_path_dir_}/plugin.tmux"
  fi

  # if --clean
  if [ "$1" = "--clean" ]; then
    cd ~/.tmux/plugins
    rm -rf tmux-float-term
  fi

  # if --ls
  if [ "$1" = "--ls" ]; then
    ls -la ~/.tmux/plugins
  fi
}

fn_dev "$@"
