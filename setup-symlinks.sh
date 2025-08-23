#!/usr/bin/env bash
[ ! -e $HOME/Scripts ] && ln -s $HOME/.config/terminal-config/scripts/ $HOME/Scripts
[ ! -e $HOME/.config/alacritty ] && ln -s $HOME/.config/terminal-config/alacritty $HOME/.config/alacritty
[ ! -e $HOME/.config/hypr ] && ln -s $HOME/.config/terminal-config/hypr $HOME/.config/hypr
[ ! -e $HOME/.config/nvim ] && ln -s $HOME/.config/terminal-config/nvim $HOME/.config/nvim
[ ! -e $HOME/.config/nvim-code ] && ln -s $HOME/.config/terminal-config/nvim-code $HOME/.config/nvim-code
[ ! -e $HOME/.config/nvim-debugger ] && ln -s $HOME/.config/terminal-config/nvim-debugger $HOME/.config/nvim-debugger
[ ! -e $HOME/.config/tmux ] && ln -s $HOME/.config/terminal-config/tmux $HOME/.config/tmux
[ ! -e $HOME/.config/waybar ] && ln -s $HOME/.config/terminal-config/waybar $HOME/.config/waybar
[ ! -e $HOME/.config/wofi ] && ln -s $HOME/.config/terminal-config/wofi $HOME/.config/wofi

rm -f $HOME/.bashrc
ln -s $HOME/.config/terminal-config/home/.bashrc $HOME/.bashrc

rm -f $HOME/.bash_profile
ln -s $HOME/.config/terminal-config/home/.bash_profile $HOME/.bash_profile

rm -f $HOME/.inputrc
ln -s $HOME/.config/terminal-config/home/.inputrc $HOME/.inputrc

git config --global user.email "andresmargar98@proton.me"
git config --global user.name "AMG"
git config --global init.defaultBranch main
git -C $HOME/.config/terminal-config submodule update --init --recursive

mkdir -p $HOME/Projects

