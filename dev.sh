#!/usr/bin/env bash
# alias: 'make [dev|clean|ls]'
# desc: run the plugin in dev mode.
# usage: dev.sh [--start|--clean|--ls]
# flags: @WIP:0 @TODO:0 @FIXME:0 @BUG:0 @OPTIMIZE:0 @REFACTOR:0 @DEPRECATED:0

declare -r _self_path_file_=$(readlink -f "$0")
declare -r _self_path_dir_=$(dirname "${_self_path_file_}")

fn_dev() {
  # if --start
  if [ "$1" = "--start" ]; then
    tmux run-shell "${_self_path_dir_}/plugin.tmux" && \
    echo '[INFO] Plugin started successfully.'
  fi

  # if --clean
  if [ "$1" = "--clean" ]; then
    cd ~/.tmux/plugins
    rm -rf tmux-float-term && \
    echo '[INFO] Plugin cleaned successfully.'
  fi

  # if --ls
  if [ "$1" = "--ls" ]; then
    ls -la ~/.tmux/plugins && \
    echo '[INFO] Plugin directory listed successfully.'
  fi
}

fn_dev "$@"
