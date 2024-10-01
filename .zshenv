#!/bin/zsh
#
# .zshenv: Zsh environment file, loaded always.
#

export ZDOTDIR=${ZDOTDIR:-$HOME/.config/zsh}

# ╭─────╮
# │ XDG │
# ╰─────╯
# basedirs
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
#export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-$HOME/.xdg}
#export XDG_PROJECTS_DIR=${XDG_PROJECTS_DIR:-$HOME/Projects}
export XDG_BIN_HOME=${XDG_BIN_HOME:-$HOME/.local/bin}
mkdir -p "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME" "$XDG_BIN_HOME"


# Fish-like dirs
: ${__zsh_config_dir:=${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}}
: ${__zsh_user_data_dir:=${XDG_DATA_HOME:-$HOME/.local/share}/zsh}
: ${__zsh_cache_dir:=${XDG_CACHE_HOME:-$HOME/.cache}/zsh}

# Ensure Zsh directories exist.
() {
  local zdir
  for zdir in $@; do
    [[ -d "${(P)zdir}" ]] || mkdir -p -- "${(P)zdir}"
  done
} __zsh_{config,user_data,cache}_dir XDG_{CONFIG,CACHE,DATA,STATE}_HOME


#
# Shell utils
#

export CURL_HOME="${XDG_CONFIG_HOME}/curl"
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
export GIT_CONFIG_GLOBAL="${XDG_CONFIG_HOME}/git/.gitconfig"
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zsh_history"
export OPENSSL_DIR="/usr/local/ssl"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/pass"
export PIP_CONFIG_FILE="${XDG_CONFIG_HOME}/pip/pip.conf"
export PIP_LOG_FILE="${XDG_DATA_HOME}/pip/log"
export PYENV_ROOT="$HOME/.pyenv"
export TEALDEER_CONFIG_DIR="${XDG_CONFIG_HOME}/tldr"
#export VIMINIT=":source $XDG_CONFIG_HOME/vim/vimrc"
export VSCODE_EXTENSIONS="${XDG_DATA_HOME:-~/.local/share}/vscode/extensions"
export ZLIB="${ZDOTDIR}/lib"

# less
export LESSKEY="${LESSKEY:-$XDG_CONFIG_HOME/less/lesskey}"
export LESSHISTFILE="${LESSHISTFILE:-$XDG_CACHE_HOME/less/history}"

# readline
export INPUTRC="${INPUTRC:-$XDG_CONFIG_HOME/readline/inputrc}"

# screen
export SCREENRC="${SCREENRC:-$XDG_CONFIG_HOME/screen/screenrc}"

# tmux
export TMUX_CONFIG="${TMUX_CONFIG:-$XDG_CONFIG_HOME/tmux/tmux.conf}"
export TMUX_PLUGIN_MANAGER_PATH="${XDG_DATA_HOME/tmux/plugins}"
alias tmux="${aliases[tmux]:-tmux} -f \"\$TMUX_CONFIG\""

# wget
export WGETRC="${WGETRC:-$XDG_CONFIG_HOME/wget/.wgetrc}"
alias wget="${aliases[wget]:-wget} --hsts-file=\$XDG_CACHE_HOME/wget/wget-hsts"

# zoxide
export _ZO_DATA_DIR="$XDG_DATA_HOME/zoxide"
export _ZO_ECHO="1"
export _ZO_RESOLVE_SYMLINKS="1"
export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS $fzf_preview"

#
# Dev tools
#

# gpg
export GNUPGHOME="${GNUPGHOME:-$XDG_DATA_HOME/gnupg}"
alias gpg="${aliases[gpg]:-gpg} --homedir \"\$GNUPGHOME\""

# node
#path+=(
#  /{opt/homebrew,usr/local}/share/npm/bin(N)
#)
export NPM_CONFIG_USERCONFIG="${NPM_CONFIG_USERCONFIG:-$XDG_CONFIG_HOME/npm/npmrc}"
export NODE_REPL_HISTORY="${NODE_REPL_HISTORY:-$XDG_DATA_HOME/nodejs/repl_history}"

# rust
export CARGO_HOME="${CARGO_HOME:-$XDG_DATA_HOME/cargo}"
export RUSTUP_HOME="${RUSTUP_HOME:-$XDG_DATA_HOME/rustup}"


# ╭──────────╮
# │ Defaults │
# ╰──────────╯

export EDITOR='code-insiders -w'
export VISUAL='code-insiders -w'

# Make Terminal.app behave.
if [[ "$OSTYPE" == darwin* ]]; then
  export SHELL_SESSIONS_DISABLE=1
fi
