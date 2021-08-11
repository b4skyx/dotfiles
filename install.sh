#!/bin/bash

: "${XDG_CONFIG_HOME:=$HOME/.config}"
: "${ZDOTDIR:=$HOME}"
echo "== Dots Installer ==="

# Disallow ctrl+c after script start as it may break things
trap "" SIGINT

# Create home if doesn't exists
mkdir -p $XDG_CONFIG_HOME

# Create a backup directory
backup_dir="backup-$(date +%s)"
mkdir -p "$HOME/$backup_dir"

# Create temp directory to cache configs
if [ -d "/tmp/dots" ]; then
	rm -rf /tmp/dots
fi
mkdir /tmp/dots

on_exit() {
	echo "Clearing cache..."
	rm -rf /tmp/dots 2> /dev/null
	rm -rf /tmp/scripts 2>/dev/null
}

# Clean temp-cache on exit
trap on_exit EXIT

clone() {
	echo "Cloning dots repo..."
	git clone https://github.com/b4skyx/dotfiles /tmp/dots/

	echo "Cloning scripts repo..."
	git clone https://github.com/b4skyx/unix-scripts /tmp/dots/scripts/
}

backup() {
	cd /tmp/dots/.config/
	echo "Creating backups for old configs..."
	for conf in *; do
		if [ -d "$XDG_CONFIG_HOME/$conf" ]; then
			mv "$XDG_CONFIG_HOME/$conf" "$HOME/$backup_dir"
			echo "Backed up: $conf"
		fi
	done

	cd /tmp/dots/zsh/
	mkdir -p "$HOME/$backup_dir/zsh/"
	echo "Backing up ZSH config..."
	for conf in .*; do
		if [ -d "$ZDOTDIR/$conf" ]; then
			mv "$ZDOTDIR/$conf" "$HOME/$backup_dir/zsh/" 2>/dev/null
		fi
	done

	cp "$HOME/.Xresources" "$HOME/$backup_dir/"
	echo "Configuration backup complete! Backup Folder: $backup_dir"
}

configure() {
	cd /tmp/dots/.config/
	echo "Creating backups for old configs..."
	for conf in *; do
		cp -rp "$conf" "$XDG_CONFIG_HOME"
	done

	cd /tmp/dots/zsh/
	for conf in .*; do
		cp -rp "$conf" "$ZDOTDIR" 2>/dev/null
	done

	cd /tmp/dots/.fonts
	for conf in *; do
		cp -rp "$conf" "$HOME/.fonts/" 2>/dev/null
	done

	cp /tmp/dots/.Xresources "$HOME/.Xresources"

	echo "Configured successfully! @b4skyx :D"
}

clone
backup
configure
