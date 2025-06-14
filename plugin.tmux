#!/usr/bin/env bash
# alias: 'n/a'
# desc: Creates a floating terminal window in tmux with customizable size, appearance, and behavior.
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

fn_plugin() {
  source "${_self_path_dir_}/libs.sh"

  # Regular floating terminal toggle
  tmux bind-key $(fn_get_final_opt "@tmux-float-term-bind" "a") run-shell "${_self_path_dir_}/main.sh"

  # Maximize floating terminal toggle
  tmux bind-key $(fn_get_final_opt "@tmux-float-term-maximize-bind" "A") run-shell "${_self_path_dir_}/main.sh --maximize"

  # Regular size configuration
  tmux setenv -g TMUX_FLOAT_TERM_WIDTH "$(fn_get_final_opt '@tmux-float-term-width' '60%')" 
  tmux setenv -g TMUX_FLOAT_TERM_HEIGHT "$(fn_get_final_opt '@tmux-float-term-height' '60%')" 

  # Maximized size configuration
  tmux setenv -g TMUX_FLOAT_TERM_MAX_WIDTH "$(fn_get_final_opt '@tmux-float-term-max-width' '90%')" 
  tmux setenv -g TMUX_FLOAT_TERM_MAX_HEIGHT "$(fn_get_final_opt '@tmux-float-term-max-height' '90%')" 

  # Other configuration
  tmux setenv -g TMUX_FLOAT_TERM_BORDER_COLOR "$(fn_get_final_opt '@tmux-float-term-border-color' 'grey')" 
  tmux setenv -g TMUX_FLOAT_TERM_TEXT_COLOR "$(fn_get_final_opt '@tmux-float-term-text-color' 'white')" 
  tmux setenv -g TMUX_FLOAT_TERM_TITLE "$(fn_get_final_opt '@tmux-float-term-title' "${DEFAULT_TITLE}")"
  tmux setenv -g TMUX_FLOAT_TERM_CHANGE_PATH "$(fn_get_final_opt '@tmux-float-term-change-path' 'true')" 
  tmux setenv -g TMUX_FLOAT_TERM_SESSION_NAME "$(fn_get_final_opt '@tmux-float-term-session-name' "${DEFAULT_SESSION_NAME}")"

  eval "$(tmux showenv -s)"
}

fn_plugin "$@"
