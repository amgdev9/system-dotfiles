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
cp $HOMEDIR/.inputrc home/.inputrc
cp $HOMEDIR/.bash_profile home/.bash_profile

mkdir -p root/etc/portage
cp /etc/portage/make.conf root/etc/portage/make.conf
cp -r /etc/portage/binrepos.conf/ root/etc/portage/binrepos.conf/
cp -r /etc/portage/repos.conf/ root/etc/portage/repos.conf/
cp -r /etc/portage/package.accept_keywords/ root/etc/portage/package.accept_keywords/
cp -r /etc/portage/package.use/ root/etc/portage/package.use/
cp -r /etc/portage/postsync.d/ root/etc/portage/postsync.d/
cp /etc/localtime root/etc/localtime
cp /etc/locale.gen root/etc/locale.gen

mkdir -p root/etc/env.d
cp /etc/env.d/02locale root/etc/env.d/02locale
cp /etc/env.d/99editor root/etc/env.d/99editor
cp /etc/fstab root/etc/fstab
cp /etc/hostname root/etc/hostname
cp /etc/rc.conf root/etc/rc.conf

mkdir -p root/etc/conf.d
cp /etc/conf.d/keymaps root/etc/conf.d/keymaps
cp /etc/conf.d/hwclock root/etc/conf.d/hwclock

mkdir -p root/etc/dracut.conf.d.amg-laptop
cp -r /etc/dracut.conf.d/* root/etc/dracut.conf.d
cp /etc/sudoers root/etc/sudoers
cp /etc/inittab root/etc/inittab
cp /etc/resolv.conf root/etc/resolv.conf

mkdir -p root/etc/apparmor
cp /etc/apparmor/parser.conf root/etc/apparmor/parser.conf 

mkdir -p root/etc/brave/policies/managed
cp -r /etc/brave/policies/managed/* root/etc/brave/policies/managed

mkdir -p root/var/lib/portage
cp /var/lib/portage/world root/var/lib/portage/world

mkdir -p root/var/repos/local
cp -r /var/db/repos/local/* root/var/repos/local

mkdir -p root/usr/share/fonts
cp /usr/share/fonts/HackNerdFontMono-Regular.ttf root/usr/share/fonts/HackNerdFontMono-Regular.ttf

mkdir -p root/etc/kernel/preinst.d
cp /etc/kernel/preinst.d/999-remove-old-uki root/etc/kernel/preinst.d/999-remove-old-uki

mkdir -p root/etc/kernel/postinst.d
cp /etc/kernel/postinst.d/999-remove-old-uki root/etc/kernel/postinst.d/999-remove-old-uki

mkdir -p root/etc/pipewire
cp /etc/pipewire/pipewire.conf root/etc/pipewire/pipewire.conf
