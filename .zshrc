#!/bin/zsh
#
# .zshrc - Run on interactive Zsh session.
#

#
# Profiling
#

[[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Fish-like dirs
__zsh_config_dir="${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}"
__zsh_user_data_dir="${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
__zsh_cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p "$__zsh_config_dir" "$__zsh_user_data_dir" "$__zsh_cache_dir"

#
# Set critical Zsh options
#
setopt EXTENDED_GLOB INTERACTIVE_COMMENTS


#
# Zstyles
#

# Load .zstyles file with customizations.
[[ -r ${ZDOTDIR:-$HOME}/.zstyles ]] && source ${ZDOTDIR:-$HOME}/.zstyles

#
# Theme
#

# Set prompt theme
#typeset -ga ZSH_THEME
#zstyle -a ':zephyr:plugin:prompt' theme ZSH_THEME ||
#ZSH_THEME=(starship mmc)

# Set helpers for antidote.
#is-theme-p10k()     { [[ "$ZSH_THEME" == (p10k|powerlevel10k)* ]] }
#is-theme-starship() { [[ "$ZSH_THEME" == starship* ]] }

#
# Libs
#

# Load things from lib.
for zlib in $ZDOTDIR/lib/*.zsh; source $zlib
unset zlib

#
# Path
#

# Ensure path arrays do not contain duplicates.
# shellcheck disable=SC2034
typeset -gU cdpath fpath mailpath path

# Add common directories.
path=(
  /usr/local/bin
  /usr/local/sbin
  $path
)

#
# Aliases
#

[[ -r ${ZDOTDIR:-$HOME}/.zaliases ]] && source ${ZDOTDIR:-$HOME}/.zaliases

#
# Misc
#

# Enable fzf zsh integration.
if type fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"
fi

#
# Completions
#

# Uncomment to manually initialize completion system, or let Zephyr
# do it automatically in the zshrc-post hook.
# ZSH_COMPDUMP=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compdump
# [[ -d $ZSH_COMPDUMP:h ]] || mkdir -p $ZSH_COMPDUMP:h
# autoload -Uz compinit && compinit -i -d $ZSH_COMPDUMP

#
# Prompt
#

# Uncomment to manually set your prompt, or let Zephyr do it automatically in the
# zshrc-post hook. Note that some prompts like powerlevel10k may not work well
# with post_zshrc.
#setopt prompt_subst transient_rprompt
#autoload -Uz promptinit && promptinit
#prompt "$ZSH_THEME[@]"

#
# Wrap up
#

# Never start in the root file system. Looking at you, Zed.
[[ "$PWD" != "/" ]] || cd

# Manually call post_zshrc to bypass the hook
(( $+functions[run_post_zshrc] )) && run_post_zshrc

# Finish profiling by calling zprof.
[[ "$ZPROFRC" -eq 1 ]] && zprof
[[ -v ZPROFRC ]] && unset ZPROFRC

# Always return success
true
