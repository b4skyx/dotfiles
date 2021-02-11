# vi-mode.zsh
A vi-mode plugin for Zsh.

## (Non-)Features
- Different cursor depending on mode (Block in normal mode and Beam in insert mode).
    This feature might not work in all terminals.
- Helper function to display mode indicators in your prompt
- No preconfigured keybindings.
    Recent versions of Zsh actually have sensible vi bindings by default.
    If you feel the need to configure them anyways, `man zshzle` is your friend.

## Installation
### zplug
```
zplug "woefe/vi-mode.zsh"
```

### Manual
Clone this repo or download the [vi-mode.zsh](./vi-mode.zsh) file.
Then source it in your `.zshrc`. For example:

```zsh
mkdir -p ~/.zsh
git clone --depth=1 https://github.com/woefe/vi-mode.zsh ~/.zsh/vi-mode.zsh
echo "source ~/.zsh/vi-mode.zsh/vi-mode.zsh" >> .zshrc
```

## Configuration
Install vi-mode.zsh as described above.
Then use the `vi_mode_status` function when setting your `PROMPT` in `.zshrc`.
Note the **single quotes** in the examples below.
If you do not use single quotes, the mode indicator will not update properly!

```zsh
# Minimal Example
PROMPT='$(vi_mode_status)'

# Example with current path
PROMPT='%B%~%b $(vi_mode_status)'

# Example with github.com/woefe/git-prompt.zsh
PROMPT='%B%~%b $(gitprompt)$(vi_mode_status)'
```

### Mode indicators
The characters used for the mode indicators can be set via `VI_NORMAL_MODE_INDICATOR` and `VI_INSERT_MODE_INDICATOR`.
You can use prompt escapes in the mode indicators (see Section "SIMPLE PROMPT ESCAPES" of `zshmisc` manpage).
The default values are:

```zsh
VI_NORMAL_MODE_INDICATOR='%(?.%F{blue}•%f%F{cyan}•%f%F{green}•%f.%F{red}•••%f) '
VI_INSERT_MODE_INDICATOR='%(?.%F{blue}❯%f%F{cyan}❯%f%F{green}❯%f.%F{red}❯❯❯%f) '
```

**Example**: Mode indicator on the right
```zsh
VI_NORMAL_MODE_INDICATOR=' %F{blue}-- NORMAL --%f'
VI_INSERT_MODE_INDICATOR=' %F{green}-- INSERT --%f'
PROMPT='%B%~%b %# '
RPROMPT='$(vi_mode_status)'
```

### Cursor
By default, the cursor changes depending on the current mode.
This behavior can be disabled by setting
```zsh
VI_MODE_KEEP_CURSOR=1
```
