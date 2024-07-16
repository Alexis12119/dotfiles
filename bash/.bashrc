# Enable vim mode
set -o vi

# enabled scroll lock
xmodmap -e "add mod3 = Scroll_Lock"

# ~/.bashrc
#
export TERM="xterm-256color" 
# set shell
export SHELL=/usr/bin/zsh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.welcome_screen ]] && . ~/.welcome_screen

_set_liveuser_PS1() {
    PS1='[\u@\h \W]\$ '
    if [ "$(whoami)" = "liveuser" ] ; then
        local iso_version="$(grep ^VERSION= /usr/lib/endeavouros-release 2>/dev/null | cut -d '=' -f 2)"
        if [ -n "$iso_version" ] ; then
            local prefix="eos-"
            local iso_info="$prefix$iso_version"
            PS1="[\u@$iso_info \W]\$ "
        fi
    fi
}
_set_liveuser_PS1
unset -f _set_liveuser_PS1

ShowInstallerIsoInfo() {
    local file=/usr/lib/endeavouros-release
    if [ -r $file ] ; then
        cat $file
    else
        echo "Sorry, installer ISO info is not available." >&2
    fi
}


alias ls='ls -a --color=auto'
alias ll='ls -lav --ignore=..'   # show long listing of all except ".."
alias l='ls -lav --ignore=.?*'   # show long listing but no hidden dotfiles except "."

[[ "$(whoami)" = "root" ]] && return

[[ -z "$FUNCNEST" ]] && export FUNCNEST=100          # limits recursive functions, see 'man bash'

## Use the up and down arrow keys for finding a command in history
## (you can write some initial letters of the command first).
# bind '"\e[A":history-search-backward'
# bind '"\e[B":history-search-forward'

################################################################################
## Some generally useful functions.
## Consider uncommenting aliases below to start using these functions.
##
## October 2021: removed many obsolete functions. If you still need them, please look at
## https://github.com/EndeavourOS-archive/EndeavourOS-archiso/raw/master/airootfs/etc/skel/.bashrc

_open_files_for_editing() {
    # Open any given document file(s) for editing (or just viewing).
    # Note1:
    #    - Do not use for executable files!
    # Note2:
    #    - Uses 'mime' bindings, so you may need to use
    #      e.g. a file manager to make proper file bindings.

    if [ -x /usr/bin/exo-open ] ; then
        echo "exo-open $@" >&2
        setsid exo-open "$@" >& /dev/null
        return
    fi
    if [ -x /usr/bin/xdg-open ] ; then
        for file in "$@" ; do
            echo "xdg-open $file" >&2
            setsid xdg-open "$file" >& /dev/null
        done
        return
    fi

    echo "$FUNCNAME: package 'xdg-utils' or 'exo' is required." >&2
}

export PATH=/opt/flutter/bin:$HOME/.local/bin:$HOME/.local/share/bob/nvim-bin:$HOME/bin:/usr/local/bin:$PATH
export CPLUS_INCLUDE_PATH=/usr/include/c++
export C_INCLUDE_PATH=/usr/include/c++
export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable
export PATH=$HOME/.config/rofi/scripts:$HOME/.local/share/nvim/mason/bin:$PATH
export GPG_TTY=$(tty)

alias apps="echo && pacman -Slq | fzf --multi --preview-window=right,60% --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-kick="NVIM_APPNAME=kickstart nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"
alias nvim-test="NVIM_APPNAME=test nvim"
alias nvim-launch="NVIM_APPNAME=Launch nvim"

nvims() {
  items=("kickstart" "LazyVim" "AstroNvim" "test" "Launch")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim "$@"
}

alias cdr='change-directory'

change-directory() {
  # Check if a specific starting directory is provided as an argument
  if [ -n "$1" ]; then
    start_directory="$1"
  else
    start_directory="$HOME"  # Default to your home directory
  fi

  # Define the command to invoke fzf and select a directory
  selectedDirectory=$(fd --type d . --hidden --exclude .git --exclude .vscode --exclude node_modules "$start_directory" | fzf --prompt='󰈚 Choose Dir: ' --layout=reverse --border=sharp --ansi --exit-0)

  # Check if a directory was selected
  if [ -n "$selectedDirectory" ]; then
    # Change the current directory to the selected directory
    cd "$selectedDirectory" || return
  fi
}

alias ff='fzf-files'

fzf-files() {
  # Define the command to invoke fzf and select a file
  selectedFile=$(fzf --prompt='󰈚 Choose File: ' --layout=reverse --border --preview 'bat --color=always {}' --ansi --exit-0)

  # Check if a file was selected
  if [ -n "$selectedFile" ]; then
    # Open the selected file in your preferred text editor (e.g., Vim or Neovim)
    nvim "$selectedFile"  # Change this line according to your preferred text editor
  fi
}

alias tss='tmux-session-switch'

tmux-session-switch() {
    local sessions
    sessions=$(tmux list-sessions -F "#S")
    local selected_session
    selected_session=$(echo "$sessions" | fzf --prompt "Switch to session: " --ansi)
    if [ -n "$selected_session" ]; then
        tmux switch-client -t "$selected_session"
    fi
}

alias qc='quick-cmd'

quick-cmd() {
    local cmd
    cmd=$(history | awk '{$1="";print $0}' | fzf --prompt "Run command: " --ansi)
    [ -z "$cmd" ] && return
    eval "$cmd"
}
#------------------------------------------------------------

## Aliases for the functions above.
## Uncomment an alias if you want to use it.
##

# alias ef='_open_files_for_editing'     # 'ef' opens given file(s) for editing
# alias pacdiff=eos-pacdiff
################################################################################
