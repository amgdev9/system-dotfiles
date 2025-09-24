host_name=$(hostname)

if [ -z "$host_name" ] || [ "$host_name" == "livecd" ]; then
  read -p "Enter hostname: " host_name
fi

if [ "$host_name" != "amg-laptop" ] && [ "$host_name" != "amg-pc" ]; then
  echo "Hostname $host_name is not valid"
  exit 1
fi

HOMEDIR=/home/amg
mkdir -p $HOMEDIR/.config
rm -rf $HOMEDIR/.config/alacritty && cp -rf alacritty $HOMEDIR/.config/alacritty
rm -rf $HOMEDIR/.config/hypr && cp -rf hypr $HOMEDIR/.config/hypr
rm -rf $HOMEDIR/.config/nvim && cp -rf nvim $HOMEDIR/.config/nvim
rm -rf $HOMEDIR/.config/waybar && cp -rf waybar $HOMEDIR/.config/waybar
rm -rf $HOMEDIR/.config/tmux && cp -rf tmux $HOMEDIR/.config/tmux
rm -rf $HOMEDIR/.config/wofi && cp -rf wofi $HOMEDIR/.config/wofi
rm -rf $HOMEDIR/Scripts && mkdir -p $HOMEDIR/Scripts && cp -rf scripts/* $HOMEDIR/Scripts/

cp -f home/.bashrc $HOMEDIR/.bashrc
cp -f home/.bashrc_root /root/.bashrc
cp -f home/.inputrc $HOMEDIR/.inputrc
cp -f home/.inputrc /root/.inputrc
cp -f home/.bash_profile $HOMEDIR/.bash_profile
cp -f home/.bash_profile /root/.bash_profile

cp -f root/etc/portage/make.conf /etc/portage/make.conf
rm -rf /etc/portage/binrepos.conf && mkdir -p /etc/portage/binrepos.conf && cp -rf root/etc/portage/binrepos.conf/* /etc/portage/binrepos.conf/
rm -rf /etc/portage/repos.conf && mkdir -p /etc/portage/repos.conf && cp -rf root/etc/portage/repos.conf/* /etc/portage/repos.conf/
rm -rf /etc/portage/package.accept_keywords && mkdir -p /etc/portage/package.accept_keywords && cp -rf root/etc/portage/package.accept_keywords/* /etc/portage/package.accept_keywords/
rm -rf /etc/portage/postsync.d && mkdir -p /etc/portage/postsync.d && cp -rf root/etc/portage/postsync.d/* /etc/portage/postsync.d/
cp -f root/etc/localtime /etc/localtime
cp -f root/etc/locale.gen /etc/locale.gen

cp -f root/etc/env.d/02locale /etc/env.d/02locale
cp -f root/etc/env.d/99editor /etc/env.d/99editor
if [ "$host_name" == "amg-laptop" ]; then
  cp -f root/etc/fstab.amg-laptop /etc/fstab
  cp -f root/etc/hostname.amg-laptop /etc/hostname
  cp -f root/var/lib/portage/world.amg-laptop /var/lib/portage/world
  rm -rf /etc/dracut.conf.d && mkdir -p /etc/dracut.conf.d && cp -rf root/etc/dracut.conf.d.amg-laptop/* /etc/dracut.conf.d/
  rm -rf /etc/portage/package.use && mkdir -p /etc/portage/package.use && cp -rf root/etc/portage/package.use/* /etc/portage/package.use/
  rm /etc/portage/package.use/nvidia
else
  cp -f root/etc/fstab.amg-pc /etc/fstab
  cp -f root/etc/hostname.amg-pc /etc/hostname
  cp -f root/var/lib/portage/world.amg-pc /var/lib/portage/world
  rm -rf /etc/dracut.conf.d && mkdir -p /etc/dracut.conf.d && cp -rf root/etc/dracut.conf.d.amg-pc/* /etc/dracut.conf.d/
  rm -rf /etc/portage/package.use && mkdir -p /etc/portage/package.use && cp -rf root/etc/portage/package.use/* /etc/portage/package.use/
fi

cp -f root/etc/rc.conf /etc/rc.conf
cp -f root/etc/conf.d/keymaps /etc/conf.d/keymaps
cp -f root/etc/conf.d/hwclock /etc/conf.d/hwclock
cp -f root/etc/sudoers /etc/sudoers
cp -f root/etc/inittab /etc/inittab
cp -f root/etc/resolv.conf /etc/resolv.conf
rm -rf /etc/apparmor && mkdir -p /etc/apparmor && cp -f root/etc/apparmor/parser.conf /etc/apparmor/parser.conf
rm -rf /etc/brave/policies/managed && mkdir -p /etc/brave/policies/managed && cp -rf root/etc/brave/policies/managed/* /etc/brave/policies/managed/
rm -rf /var/db/repos/local && mkdir -p /var/db/repos/local && cp -rf root/var/repos/local/* /var/db/repos/local/
cp -f root/usr/share/fonts/HackNerdFontMono-Regular.ttf /usr/share/fonts/HackNerdFontMono-Regular.ttf
rm -rf /etc/kernel/preinst.d && mkdir -p /etc/kernel/preinst.d && cp -f root/etc/kernel/preinst.d/999-remove-old-uki /etc/kernel/preinst.d/999-remove-old-uki
if [ "$host_name" == "amg-laptop" ]; then
  rm -rf /etc/kernel/postinst.d && mkdir -p /etc/kernel/postinst.d && cp -f root/etc/kernel/postinst.d/999-remove-old-uki.amg-laptop /etc/kernel/postinst.d/999-remove-old-uki
else
  rm -rf /etc/kernel/postinst.d && mkdir -p /etc/kernel/postinst.d && cp -f root/etc/kernel/postinst.d/999-remove-old-uki.amg-pc /etc/kernel/postinst.d/999-remove-old-uki
fi

rm -rf /etc/pipewire && mkdir -p /etc/pipewire && cp -f root/etc/pipewire/pipewire.conf /etc/pipewire/pipewire.conf

chown -R amg:amg $HOMEDIR/.config $HOMEDIR/.bashrc $HOMEDIR/.bash_profile $HOMEDIR/.inputrc $HOMEDIR/Scripts

