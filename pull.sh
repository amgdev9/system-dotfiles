HOMEDIR=/home/amg
rm -rf alacritty && cp -rf $HOMEDIR/.config/alacritty .
rm -rf hypr && cp -rf $HOMEDIR/.config/hypr .
rm -rf nvim && cp -rf $HOMEDIR/.config/nvim .
rm -rf waybar && cp -rf $HOMEDIR/.config/waybar .
rm -rf tmux && cp -rf $HOMEDIR/.config/tmux .
rm -rf wofi && cp -rf $HOMEDIR/.config/wofi .
rm -rf scripts && cp -rf $HOMEDIR/Scripts ./scripts
rm -rf root && mkdir root 
rm -rf home && mkdir home

cp $HOMEDIR/.bashrc home/.bashrc
cp /root/.bashrc home/.bashrc_root
cp /root/.gitconfig home/.gitconfig_root
cp $HOMEDIR/.inputrc home/.inputrc
cp $HOMEDIR/.gitconfig home/.gitconfig
cp $HOMEDIR/.bash_profile home/.bash_profile

mkdir -p root/usr/share/libalpm/hooks
cp -r /usr/share/libalpm/hooks/zz-amg-apparmor.hook root/usr/share/libalpm/hooks

mkdir -p root/opt
cp -r /opt/apparmor.d root/opt
cp -r /opt/aur root/aur

mkdir -p root/etc
cp /etc/sudoers root/etc
cp /etc/locale.gen root/etc
cp /etc/mkinitcpio.conf root/etc
cp /etc/resolv.conf root/etc
cp /etc/hostname root/etc
cp /etc/vconsole.conf root/etc

mkdir -p root/etc/apparmor
cp /etc/apparmor/parser.conf root/etc/apparmor

mkdir -p root/etc/brave/policies/managed
cp -r /etc/brave/policies/managed/* root/etc/brave/policies/managed

mkdir -p root/etc/NetworkManager/conf.d
cp -r /etc/NetworkManager/conf.d/* root/etc/NetworkManager/conf.d

mkdir -p root/etc/cmdline.d
cp -r /etc/cmdline.d/* root/etc/cmdline.d

mkdir -p root/etc/mkinitcpio.d
cp -r /etc/mkinitcpio.d/* root/etc/mkinitcpio.d

mkdir -p root/etc/profile.d
cp /etc/profile.d/99-editor.sh root/etc/profile.d

mkdir -p root/systemd/system/getty@tty1.service
cp /etc/systemd/system/getty@tty1.service/override.conf root/systemd/system/getty@tty1.service
