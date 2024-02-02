# Enable vim mode
bindkey -v

# If you come from bash you might have to change your $PATH.
export PATH=/opt/flutter/bin:$HOME/.local/bin:$HOME/.local/share/bob/nvim-bin:$HOME/bin:/usr/local/bin:$PATH
export CPLUS_INCLUDE_PATH=/usr/include/c++
export CPLUS_INCLUDE_PATH=/usr/include/c++
export C_INCLUDE_PATH=/usr/include/c++
export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable
export PATH=$HOME/.config/rofi/scripts:$HOME/.local/share/nvim/mason/bin:$PATH

export GPG_TTY=$(tty)

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"
# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking

# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-vi-mode)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias ls="ls -a --color=auto"

alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-kick="NVIM_APPNAME=kickstart nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"
alias nvim-test="NVIM_APPNAME=test nvim"
alias nvim-launch="NVIM_APPNAME=Launch nvim"

function nvims() {
  items=("kickstart" "LazyVim" "AstroNvim" "test", "Launch")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

alias cdr='change-directory'

# Change Directory through fzf
function change-directory() {
# Check if a specific starting directory is provided as an argument
  if [ -n "$1" ]; then
    start_directory="$1"
  else
    start_directory="$HOME"  # Default to your home directory
  fi

  # Define the command to invoke fzf and select a directory
  selectedDirectory=$(fd --type d . --hidden --exclude .git --exclude .vscode --exclude node_modules  "$start_directory" | fzf --prompt='󰈚 Choose Dir: ' --layout=reverse --border=sharp --ansi --exit-0)

  # Check if a directory was selected
  if [ -n "$selectedDirectory" ]; then
    # Change the current directory to the selected directory
    cd "$selectedDirectory" || return
  fi
}

alias ff='fzf-files'

# Open files from fzf
function fzf-files() {
  # Define the command to invoke fzf and select a file
  selectedFile=$(fzf --prompt='󰈚 Choose File: ' --layout=reverse --border --preview 'bat --color=always {}' --ansi --exit-0)
  # selectedFile=$(find "$HOME" -type f | fzf --prompt='󰈚 Choose File: ' --layout=reverse --border --preview 'bat --color=always {}' --exit-0)

  # Check if a file was selected
  if [ -n "$selectedFile" ]; then
    # Open the selected file in your preferred text editor (e.g., Vim or Neovim)
    nvim "$selectedFile"  # Change this line according to your preferred text ediltor
  fi
}

alias tss='tmux-session-switch'

# Switch tmux sessions through fzf
function tmux-session-switch() {
    local sessions
    sessions=$(tmux list-sessions -F "#S")
    local selected_session
    selected_session=$(echo "$sessions" | fzf --prompt "Switch to session: " --ansi)
    if [ -n "$selected_session" ]; then
        tmux switch-client -t "$selected_session"
    fi
}

alias qc='quick-cmd'

# Execute previously run shell commands
function quick-cmd() {
    local cmd
    cmd=$(history | awk '{$1="";print $0}' | fzf --prompt "Run command: " --ansi)
    [ -z "$cmd" ] && return
    eval "$cmd"
}
