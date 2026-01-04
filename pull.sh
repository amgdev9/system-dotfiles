rm -rf alacritty && cp -rf $HOME/.config/alacritty .
rm -rf nvim && cp -rf $HOME/.config/nvim .
rm -rf tmux && cp -rf $HOME/.config/tmux .
rm -rf scripts && cp -rf $HOME/Scripts ./scripts
rm -rf root && mkdir root 
rm -rf home && mkdir home

cp $HOME/.bashrc home/.bashrc
sudo cp /root/.bashrc home/.bashrc_root
sudo cp /root/.gitconfig home/.gitconfig_root
cp $HOME/.inputrc home/.inputrc
cp $HOME/.gitconfig home/.gitconfig
cp $HOME/.bash_profile home/.bash_profile

sudo mkdir -p root/etc/brave/policies/managed
sudo cp -r /etc/brave/policies/managed/* root/etc/brave/policies/managed

