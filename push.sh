mkdir -p $HOME/.config
mkdir -p /var/root/.config
rm -rf $HOME/.config/alacritty && cp -rf alacritty $HOME/.config/alacritty
rm -rf $HOME/.config/nvim && cp -rf nvim $HOME/.config/nvim
sudo rm -rf /var/root/.config/nvim && sudo cp -rf nvim /var/root/.config/nvim
rm -rf $HOME/.config/tmux && cp -rf tmux $HOME/.config/tmux
rm -rf $HOME/Scripts && mkdir -p $HOME/Scripts && cp -rf scripts/* $HOME/Scripts/

cp -f home/.bashrc $HOME/.bashrc
sudo cp -f home/.bashrc_root /root/.bashrc
cp -f home/.inputrc $HOME/.inputrc
sudo cp -f home/.inputrc /root/.inputrc
cp -f home/.bash_profile $HOME/.bash_profile
sudo cp -f home/.bash_profile /root/.bash_profile
cp -f home/.gitconfig $HOME/.gitconfig
sudo cp -f home/.gitconfig_root /root/.gitconfig

sudo mkdir -p /etc/brave/policies
sudo rm -rf /etc/brave/policies/managed && sudo cp -rf root/etc/brave/policies/managed /etc/brave/policies

echo "Done"
