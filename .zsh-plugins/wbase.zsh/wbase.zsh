# wbase.zsh -- Woefe's core Zsh config based on grml-etc-core
# Copyright © 2019 Wolfgang Popp and grml contributors
#
# SPDX-License-Identifier: GPL-2.0-only

#{{{ Utility functions
function check_prog() {
     (( ${+commands[$1]} )) && return 0
    return 1
}

function maybe_source() {
    if test -r "$1"; then
        source "$1"
        return 0
    fi
    return 1
}
#}}}

#{{{ Zsh Line Editor widgets
# edit current command with $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line

function slash-backward-kill-word () {
    local WORDCHARS="${WORDCHARS:s@/@}"
    # zle backward-word
    zle backward-kill-word
}
zle -N slash-backward-kill-word
#}}}

#{{{ less and ls colors
# color setup for ls:
check_prog dircolors && eval $(dircolors -b)

# support colors in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
#}}}

#{{{ Completion
COMPDUMPCACHEDIR=$HOME/.zcompdumpcache/
if ! (( $+functions[zplug] )); then
    COMPDUMPFILE=$HOME/.zcompdump
    autoload -Uz compinit && compinit -d $COMPDUMPFILE
fi

function setup_completion() {
    # allow one error for every three characters typed in approximate completer
    zstyle ':completion:*:approximate:'    max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'

    # don't complete backup files as executables
    zstyle ':completion:*:complete:-command-::commands' ignored-patterns '(aptitude-*|*\~)'

    # start menu completion only if it could find no unambiguous initial string
    zstyle ':completion:*:correct:*'       insert-unambiguous true
    zstyle ':completion:*:corrections'     format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
    zstyle ':completion:*:correct:*'       original true

    # activate color-completion
    zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}

    # format on completion
    zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'

    # automatically complete 'cd -<tab>' and 'cd -<ctrl-d>' with menu
    # zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

    # insert all expansions for expand completer
    zstyle ':completion:*:expand:*'        tag-order all-expansions
    zstyle ':completion:*:history-words'   list false

    # activate menu
    zstyle ':completion:*:history-words'   menu yes

    # ignore duplicate entries
    zstyle ':completion:*:history-words'   remove-all-dups yes
    zstyle ':completion:*:history-words'   stop yes

    # match uppercase from lowercase
    zstyle ':completion:*'                 matcher-list 'm:{a-z}={A-Z}'

    # separate matches into groups
    zstyle ':completion:*:matches'         group 'yes'
    zstyle ':completion:*'                 group-name ''

    zstyle ':completion:*'                 menu select

    zstyle ':completion:*:messages'        format '%d'
    zstyle ':completion:*:options'         auto-description '%d'

    # describe options in full
    zstyle ':completion:*:options'         description 'yes'

    # on processes completion complete all user processes
    zstyle ':completion:*:processes'       command 'ps -au$USER'

    # offer indexes before parameters in subscripts
    zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

    # provide verbose completion information
    zstyle ':completion:*'                 verbose true

    # recent (as of Dec 2007) zsh versions are able to provide descriptions
    # for commands (read: 1st word in the line) that it will list for the user
    # to choose from. The following disables that, because it's not exactly fast.
    zstyle ':completion:*:-command-:*:'    verbose false

    # set format for warnings
    zstyle ':completion:*:warnings'        format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d'

    # define files to ignore for zcompile
    zstyle ':completion:*:*:zcompile:*'    ignored-patterns '(*~|*.zwc)'
    zstyle ':completion:correct:'          prompt 'correct to: %e'

    # Ignore completion functions for commands you don't have:
    zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'

    # Provide more processes in completion of programs like killall:
    zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'

    # complete manual by their section
    zstyle ':completion:*:manuals'    separate-sections true
    zstyle ':completion:*:manuals.*'  insert-sections   true
    zstyle ':completion:*:man:*'      menu yes select

    # Search path for sudo completion
    zstyle ':completion:*:sudo:*' command-path /usr/local/sbin \
                                               /usr/local/bin  \
                                               /usr/sbin       \
                                               /usr/bin        \
                                               /sbin           \
                                               /bin            \
                                               /usr/X11R6/bin

    # provide .. as a completion
    zstyle ':completion:*' special-dirs ..

    # run rehash on completion so new installed program are found automatically:
    function _force_rehash() {
        (( CURRENT == 1 )) && rehash
        return 1
    }

    # correction
    setopt correct
    zstyle -e ':completion:*' completer '
        if [[ $_last_try != "$HISTNO$BUFFER$CURSOR" ]] ; then
            _last_try="$HISTNO$BUFFER$CURSOR"
            reply=(_complete _match _ignored _prefix _files)
        else
            if [[ $words[1] == (rm|mv) ]] ; then
                reply=(_complete _files)
            else
                reply=(_oldlist _expand _force_rehash _complete _ignored _correct _approximate _files)
            fi
        fi'

    # command for process lists, the local web server details and host completion
    zstyle ':completion:*:urls' local 'www' '/var/www/' 'public_html'

    # Some functions, like _apt and _dpkg, are very slow. We can use a cache in
    # order to speed things up
    zstyle ':completion:*' use-cache  yes
    zstyle ':completion:*' cache-path "$COMPDUMPCACHEDIR"

    [[ -r ~/.ssh/config ]] && _ssh_config_hosts=(${${(s: :)${(ps:\t:)${${(@M)${(f)"$(<$HOME/.ssh/config)"}:#Host *}#Host }}}:#*[*?]*}) || _ssh_config_hosts=()
    [[ -r ~/.ssh/known_hosts ]] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
    [[ -r /etc/hosts ]] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()
    hosts=(
        $(hostname)
        "$_ssh_config_hosts[@]"
        "$_ssh_hosts[@]"
        "$_etc_hosts[@]"
        localhost
    )
    zstyle ':completion:*:hosts' hosts $hosts
}
setup_completion
unfunction setup_completion
#}}}

#{{{ Options

# Report time stats of commands running longer than 20 sec
REPORTTIME=20

# in order to use #, ~ and ^ for filename generation grep word
# *~(*.gz|*.bz|*.bz2|*.zip|*.Z) -> searches for word not in compressed files
# don't forget to quote '^', '~' and '#'!
setopt extended_glob

# if a command is issued that can't be executed as a normal command, and the
# command is the name of a directory, perform the cd command to that directory.
setopt auto_cd

# display PID when suspending processes as well
setopt long_list_jobs

# report the status of backgrounds jobs immediately
setopt notify

# whenever a command completion is attempted, make sure the entire command path
# is hashed first.
setopt hash_list_all

# not just at the end
setopt complete_in_word

# Don't send SIGHUP to background processes when the shell exits.
setopt no_hup

# avoid "beep"ing
setopt no_beep

# * shouldn't match dotfiles. ever.
setopt no_glob_dots

# use zsh style word splitting
setopt no_sh_word_split

# don't error out when unset parameters are used
setopt unset
#}}}

#{{{ History settings
HISTSIZE=100000
SAVEHIST=100000
HISTFILE="$HOME/.zsh_history"
setopt append_history         # append history instead of replacing
setopt hist_ignore_all_dups   # ignore duplication command history list
setopt hist_ignore_space      # ignore commands that start with a space
setopt hist_verify            # don't execute command from history directly but edit it first
setopt share_history          # share history between simultaneously running shells
#}}}

#{{{ Distrack and pushd
setopt auto_pushd             # make cd push the old directory onto the directory stack.
setopt pushd_ignore_dups      # don't push the same dir twice.
DIRSTACKSIZE=20               # Max number of items on dirstack
DIRSTACKFILE="$HOME/.zdirs"

function write_dirstack() {
    (( $DIRSTACKSIZE <= 0 )) && return
    [[ -z $DIRSTACKFILE ]] && return

    # Array with unique values
    typeset -aU dedup
    dedup=( $PWD "${dirstack[@]}" )

    print -l $dedup >! $DIRSTACKFILE
}

autoload -U add-zsh-hook
add-zsh-hook chpwd write_dirstack

if [[ -f ${DIRSTACKFILE} ]]; then
    # Read dirstack from file and filter out all non-existing directories
    # (f): split at newline
    # ${^...}: set RC_EXPAND_PARAM. ${^var} becomes {$var[1],$var[2],...}
    # (/N): / to filter directories. N for NULL_GLOB to silently ignore nonexisting dirs
    dirstack=( ${^${(f)"$(< $DIRSTACKFILE)"}}(/N) )

    # Populate `cd -` behavior after startup
    [[ -d $dirstack[1] ]] && cd -q $dirstack[1] && cd -q $OLDPWD
fi
#}}}

#{{{ Window title
# adjust title of xterm compatible terminal
# see http://www.faqs.org/docs/Linux-mini/Xterm-Title.html

case $TERM in
    (xterm*|rxvt*)
        function _set_title() {
            printf '%s' $'\e]0;'
            printf '%s' "$*"
            printf '%s' $'\a'
        }

        function _reset_title() {
            _set_title ${(%):-"%n@%m: %~"}
        }

        function _set_command_title() {
            _set_title "${(%):-"%n@%m:"}" "$1"
        }

        add-zsh-hook precmd _reset_title
        add-zsh-hook preexec _set_command_title
        ;;
esac

#}}}

#{{{ Keybindings
# allow ctrl+a and ctrl+e to move to beginning/end of line
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# alt+q to push current line and fetch again on next line
bindkey '\eq' push-line

# show man page of current command with alt+h
bindkey '\eh' run-help

# ctrl+left, ctrl+right to wo to next word
# alt+left, alt+right to wo to next word
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word

# allow backspace, alt+backspace, ctrl+backspace, ctrl+w for char and word deletion
# These escape sequences are different depending on your terminal
bindkey '^?' backward-delete-char
bindkey '^[[3~' delete-char
bindkey '\e^?' slash-backward-kill-word
bindkey '^H' slash-backward-kill-word
bindkey '^w' slash-backward-kill-word

# Shift-Tab to go back in completion menu
zmodload -i zsh/complist  # Needed for keybindings in menucomplete mode, and completion styling
bindkey -M menuselect '^[[Z' reverse-menu-complete

# Gets the nth argument from the last command by pressing Alt+1, Alt+2, ... Alt+5
bindkey -s '\e1' "!:0-0 \t"
bindkey -s '\e2' "!:1-1 \t"
bindkey -s '\e3' "!:2-2 \t"
bindkey -s '\e4' "!:3-3 \t"
bindkey -s '\e5' "!:4-4 \t"
#}}}

#{{{ Useful functions
# prevent man from displaying lines wider than 120 characters
function man(){
    MANWIDTH=120
    if (( MANWIDTH > COLUMNS )); then
        MANWIDTH=$COLUMNS
    fi
    MANWIDTH=$MANWIDTH /usr/bin/man $*
    unset MANWIDTH
}

# cd to directory and list files
function cl() {
    emulate -L zsh
    cd $1 && ls -a
}

# Smart cd function. cd to parent dir if file is given.
function cd() {
    if (( ${#argv} == 1 )) && [[ -f ${1} ]]; then
        [[ ! -e ${1:h} ]] && return 1
        print "Correcting ${1} to ${1:h}"
        builtin cd ${1:h}
    else
        builtin cd "$@"
    fi
}

# Create Directory and cd to it
function mkcd() {
    if (( ARGC != 1 )); then
        printf 'usage: mkcd <new-directory>\n'
        return 1;
    fi
    if [[ ! -d "$1" ]]; then
        command mkdir -p "$1"
    else
        printf '`%s'\'' already exists: cd-ing.\n' "$1"
    fi
    builtin cd "$1"
}

# Create temporary directory and cd to it
function cdt() {
    builtin cd "$(mktemp -d)"
    builtin pwd
}

# A small wrapper for qrencode (https://fukuchi.org/works/qrencode/).
# Wraps the output of qrencode to have high black and white contrast.
# Usage:
# - With pipes: xclip -o | mkqrcode
# - With arguments: mkqrcode "hello world"
function mkqrcode() {
    data="$@"
    [[ -z "$data" ]] && IFS='' read -rd '' data
    echo "\e[48;5;231m\e[38;5;232m"
    qrencode -t utf8i -o - "$data"
    echo "\e[0m"
}
#}}}

# vim:foldmethod=marker
