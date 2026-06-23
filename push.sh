HOMEDIR=/home/amg
mkdir -p $HOMEDIR/.config
mkdir -p /root/.config
rm -rf $HOMEDIR/.config/alacritty && cp -rf alacritty $HOMEDIR/.config/alacritty
rm -rf $HOMEDIR/.config/hypr && cp -rf hypr $HOMEDIR/.config
rm -rf $HOMEDIR/.config/nvim && cp -rf nvim $HOMEDIR/.config/nvim
rm -rf /root/.config/nvim && cp -rf nvim /root/.config/nvim
rm -rf $HOMEDIR/.config/waybar && cp -rf waybar $HOMEDIR/.config/waybar
rm -rf $HOMEDIR/.config/tmux && cp -rf tmux $HOMEDIR/.config/tmux
rm -rf $HOMEDIR/.config/wofi && cp -rf wofi $HOMEDIR/.config/wofi
rm -rf $HOMEDIR/.config/wireplumber && cp -rf wireplumber $HOMEDIR/.config/wireplumber
rm -rf $HOMEDIR/Scripts && mkdir -p $HOMEDIR/Scripts && cp -rf scripts/* $HOMEDIR/Scripts/

cp -f home/.bashrc $HOMEDIR/.bashrc
cp -f home/.bashrc_root /root/.bashrc
cp -f home/.inputrc $HOMEDIR/.inputrc
cp -f home/.inputrc /root/.inputrc
cp -f home/.bash_profile $HOMEDIR/.bash_profile
cp -f home/.bash_profile /root/.bash_profile
cp -f home/.gitconfig $HOMEDIR/.gitconfig
cp -f home/.gitconfig_root /root/.gitconfig
chown -R amg:amg $HOMEDIR/.config $HOMEDIR/.bashrc $HOMEDIR/.bash_profile $HOMEDIR/.inputrc $HOMEDIR/Scripts $HOMEDIR/.gitconfig

rm -rf /opt/aur && cp -rf root/opt/aur /opt
chown -R amg:amg /opt/aur

cp -f root/etc/locale.gen /etc
cp -f root/etc/sudoers /etc
cp -f root/etc/mkinitcpio.conf /etc
chattr -i /etc/resolv.conf && cp -f root/etc/resolv.conf /etc && chattr +i /etc/resolv.conf
cp -f root/etc/hostname /etc
cp -f root/etc/vconsole.conf /etc
cp -f root/etc/locale.conf /etc

mkdir -p /etc/brave/policies
rm -rf /etc/brave/policies/managed && cp -rf root/etc/brave/policies/managed /etc/brave/policies

rm -rf /etc/NetworkManager/conf.d && cp -rf root/etc/NetworkManager/conf.d /etc/NetworkManager

rm -rf /etc/cmdline.d && cp -rf root/etc/cmdline.d /etc

rm -rf /etc/mkinitcpio.d && cp -rf root/etc/mkinitcpio.d /etc

cp -f root/etc/profile.d/99-editor.sh /etc/profile.d

rm -rf /etc/systemd/system/getty@tty1.service.d && cp -rf root/etc/systemd/system/getty@tty1.service.d /etc/systemd/system

echo "Done, reboot is recommended"
