arch-chroot /mnt/gentoo
echo "nameserver 1.1.1.1" >> /etc/resolv.conf
passwd -l root
useradd -m -G users,wheel,video -s /bin/bash amg
passwd amg
emerge-webrsync
getuto
emerge -a dev-vcs/git
git clone https://github.com/amgdev9/system-dotfiles
mkdir -p /efi/EFI/Linux
./push.sh
locale-gen
emerge -a app-crypt/sbctl
sbctl create-keys
sbctl enroll-keys -m
emerge --ask --deep --newuse --update @world
emerge --depclean
usermod -aG pipewire,plugdev amg
rc-update add bluetooth default
rc-update add NetworkManager default
rc-update add apparmor boot
su amg -c "flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo"
flatpak override --system --no-talk-name=org.freedesktop.ScreenSaver --no-talk-name=org.freedesktop.UDisks2
git config --global user.email "andresmargar98@proton.me"
git config --global user.name "Andrés Martínez"
git config --global init.defaultBranch main
git config --global push.autoSetupRemote true
su - amg -s /bin/bash <<'EOF'
git config --global user.email "andresmargar98@proton.me"
git config --global user.name "AMG"
git config --global init.defaultBranch main
git config --global push.autoSetupRemote true
EOF
