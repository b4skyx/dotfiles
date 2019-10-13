# wbase
A stripped down version of Grml's zsh config.

## Why?
- Faster startup. wbase.zsh avoids the many Zsh version checks of Grml's config (requires Zsh 5.4 or newer)
- Better integration with plugin managers like [zplug](https://github.com/zplug/zplug)
- No prompt, because there are better alternatives. You can set your own prompt for example with [git-prompt.zsh](https://github.com/woefe/git-prompt.zsh) or [powerlevel10k](https://github.com/romkatv/powerlevel10k)

## Installation
### zplug
```
zplug "woefe/wbase.zsh"
```

### Manual
Clone this repo or download the [wbase.zsh](./wbase.zsh) file.
Then source it in your `.zshrc`. For example:

```bash
mkdir -p ~/.zsh
git clone --depth=1 https://github.com/woefe/wbase.zsh ~/.zsh/wbase.zsh
echo "source ~/.zsh/wbase.zsh/wbase.zsh" >> .zshrc
```

## Features
- `less` colors
- `ls` colors (requires `alias ls=ls --color=auto`)
- text width of `man` limited to 120 characters
- Menu completion with sections
- Large history (100000 items)
- Autopushd and persistent dirstack
- Easier dirstack handling. (Type `cd -<TAB>` or `cd +<TAB>` to go to recently visited directories)
- Terminal title for xterm based terminals
- Useful keybindings:
    - `Alt+q`: push-line; save current command line, and re-display in next prompt.
    - `Alt+h`: run-help; show man page of current command
    - `Alt+1` to `Alt+5`: get first to fifth parameter of previous command
- Useful functions:
    - `mkcd`: make directory and cd into it
    - `cdt`: make a temporary directory and cd into it
    - `cl`: change directory and list files
    - `mkqrcode`: create QR-Code from stdin or arguments (depends on [qrencode](https://fukuchi.org/works/qrencode/))
