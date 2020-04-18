# vi-mode.zsh -- vi mode for Zsh
# Copyright © 2019 Wolfgang Popp
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

#
# Usage
# -----
#
# Source this file in your .zshrc and add '$(vi_mode_status)' to your prompt.
#
#
# Settings
# --------
#
# Set these variables before sourcing this file.
#   VI_NORMAL_MODE_INDICATOR: the prompt indicator in normal mode
#   VI_INSERT_MODE_INDICATOR: the prompt indicator in insert mode
#   VI_MODE_KEEP_CURSOR: set this to anything to keep your default cursor style
#                        independent of the current mode
#


# Updates editor information when the keymap changes.
function zle-keymap-select() {
    # Update keymap variable for the prompt
    VI_KEYMAP=$KEYMAP

    # Change cursor depending on mode.
    # Block cursor in "normal" mode, Beam in insert mode.
    [[ -n "$VI_MODE_KEEP_CURSOR" ]] || if [[ "$VI_KEYMAP" == "vicmd" ]]; then
        print -n '\e[1 q'
    else
        print -n '\e[5 q'
    fi

    zle reset-prompt
    zle -R
}

# Start every prompt in insert mode
function zle-line-init() {
    zle -K viins
}

zle -N zle-line-init
zle -N zle-keymap-select

# Reset the cursor to block style before running applications
function _vi_mode_reset_cursor() {
    [[ -n "$VI_MODE_KEEP_CURSOR" ]] || print -n '\e[1 q'
}
autoload -U add-zsh-hook
add-zsh-hook preexec _vi_mode_reset_cursor

# Enable vi keymap
bindkey -v

# Reduce esc delay
export KEYTIMEOUT=1

# Set indicators, if not already set
: "${VI_NORMAL_MODE_INDICATOR="%(?.%F{blue}•%f%F{cyan}•%f%F{green}•%f.%F{red}•••%f) "}"
: "${VI_INSERT_MODE_INDICATOR="%(?.%F{blue}❯%f%F{cyan}❯%f%F{green}❯%f.%F{red}❯❯❯%f) "}"

# Enable prompt substition. Necessary to use vi_mode_status in your prompt
setopt PROMPT_SUBST

# This function is used in the prompt.
# For example:
#
#PROMPT='$(vi_mode_status)'
function vi_mode_status() {
    if [[ "$VI_KEYMAP" == "vicmd" ]]; then
        echo "$VI_NORMAL_MODE_INDICATOR"
    else
        echo "$VI_INSERT_MODE_INDICATOR"
    fi
}
