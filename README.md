```
              ▄▄                         ▄▄▄▄      ██     ▄▄▄▄
              ██              ██        ██▀▀▀      ▀▀     ▀▀██
         ▄███▄██   ▄████▄   ███████   ███████    ████       ██       ▄████▄   ▄▄█████▄
        ██▀  ▀██  ██▀  ▀██    ██        ██         ██       ██      ██▄▄▄▄██  ██▄▄▄▄ ▀
        ██    ██  ██    ██    ██        ██         ██       ██      ██▀▀▀▀▀▀   ▀▀▀▀██▄
        ▀██▄▄███  ▀██▄▄██▀    ██▄▄▄     ██      ▄▄▄██▄▄▄    ██▄▄▄   ▀██▄▄▄▄█  █▄▄▄▄▄██
          ▀▀▀ ▀▀    ▀▀▀▀       ▀▀▀▀     ▀▀      ▀▀▀▀▀▀▀▀     ▀▀▀▀     ▀▀▀▀▀    ▀▀▀▀▀▀
```

Cause every developer needs one!

### The following dotfiles contain configuration for
- BSPWM (Window Mangaer)
- nvim/vim
- alacritty (Terminal)
- zsh (shell)
- conky (widget)
- mpv (Media Player)
- ranger (File Manager)
- rofi (Application Launcher)
- Conky (Desktop Widget)

---

## Screenshot

![current_setup](./current_state.png)

## Configuration

You could either copy the configs or replace them manually.

If you want to be updated with configs, I recommend you having symlinks to my repo.
The ``symlink.sh`` file has appropriate code to do this for you.

*The detailed steps are as follows:*

```
git clone https://github.com/b4skyx/dotfiles.git
cd dotfiles
```

Edit the ``symlink.sh`` file and comment out the lines for whose config you do not want to replace.
It can be done so by inserting a ``#`` at the front of the lines.

After doing so, make the file executable and run.

```
chmod +x symlink.sh
./symlink.sh
```
