#!/usr/bin/env bash
LOCATION=$HOME/.config/terminal-config

[ ! -e $HOME/Scripts ] && ln -s $LOCATION/scripts/ $HOME/Scripts
[ ! -e $HOME/.config/alacritty ] && ln -s $LOCATION/alacritty $HOME/.config/alacritty
[ ! -e $HOME/.config/hypr ] && ln -s $LOCATION/hypr $HOME/.config/hypr
[ ! -e $HOME/.config/nvim ] && ln -s $LOCATION/nvim $HOME/.config/nvim
[ ! -e $HOME/.config/nvim-code ] && ln -s $LOCATION/nvim-code $HOME/.config/nvim-code
[ ! -e $HOME/.config/nvim-debugger ] && ln -s $LOCATION/nvim-debugger $HOME/.config/nvim-debugger
[ ! -e $HOME/.config/tmux ] && ln -s $LOCATION/tmux $HOME/.config/tmux
[ ! -e $HOME/.config/waybar ] && ln -s $LOCATION/waybar $HOME/.config/waybar
[ ! -e $HOME/.config/wofi ] && ln -s $LOCATION/wofi $HOME/.config/wofi

rm -f $HOME/.bashrc
ln -s $LOCATION/home/.bashrc $HOME/.bashrc

rm -f $HOME/.bash_profile
ln -s $LOCATION/home/.bash_profile $HOME/.bash_profile

rm -f $HOME/.inputrc
ln -s $LOCATION/home/.inputrc $HOME/.inputrc

git config --global user.email "andresmargar98@proton.me"
git config --global user.name "AMG"
git config --global init.defaultBranch main
git -C $LOCATION submodule update --init --recursive

sudo cp $LOCATION/home/.bashrc_root /root/.bashrc

mkdir -p $HOME/Projects

