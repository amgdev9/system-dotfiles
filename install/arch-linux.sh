trap 'exit' INT

echo Make sure the following is done:
echo - Connect to internet using iwctl
echo "- Format partitions and mount them in /mnt and /mnt/efi (in /mnt the luks partition)"
echo - Make sure secure boot is in setup mode
echo - Remove unneeded boot entries with efibootmgr
read -p "Type 'yes' to continue: " answer
if [ "$answer" != "yes" ]; then
    echo Aborted
    exit 1
fi

read -p "Enter the disk device where UEFI partition is: " uefi_disk
read -p "Enter the UEFI partition number: " uefi_part_number
read -p "Enter the LUKS partition device: " luks_device
read -p "Is this amg-laptop? [Y/n]: " is_laptop
read -s -p "Enter password: " amg_passwd
echo
read -s -p "Repeat password: " amg_passwd2
echo

if [[ "$amg_passwd" != "$amg_passwd2" ]]; then
    echo "Passwords do not match"
    exit 1
fi

timedatectl
pacstrap -K /mnt base base-devel linux linux-firmware amd-ucode neovim tmux alacritty networkmanager man-db man-pages texinfo sudo sbctl bubblewrap podman hyprland uwsm libnewt hyprlock swaybg wofi brightnessctl waybar pipewire pipewire-audio pipewire-pulse pipewire-alsa pipewire-jack bluez bluez-utils bluetui git github-cli git-lfs htop rclone ripgrep wl-clipboard grim bind ttf-hack-nerd ttf-liberation noto-fonts-emoji xdg-desktop-portal-hyprland bash-completion
genfstab -U /mnt >> /mnt/etc/fstab

# Locale
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /mnt/etc/locale.gen
rm /mnt/etc/vconsole.conf
echo "KEYMAP=es" >> /mnt/etc/vconsole.conf

# Add LUKS hook to initramfs
sed -i 's/^HOOKS=.*/HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block encrypt filesystems fsck)/' /mnt/etc/mkinitcpio.conf

# Setup UKI (default and fallback)
mkdir -p /mnt/etc/cmdline.d
luks_uuid=$(blkid "$luks_device" | sed -n 's/.* UUID="\([^"]*\)".*/\1/p')
echo "cryptdevice=UUID=$luks_uuid:root" >> /mnt/etc/cmdline.d/root.conf
echo "root=/dev/mapper/root rw" >> /mnt/etc/cmdline.d/root.conf
sed -i 's|^#default_uki=.*|default_uki="/efi/EFI/Linux/arch-linux.efi"|' /mnt/etc/mkinitcpio.d/linux.preset
sed -i 's|^#fallback_uki=.*|fallback_uki="/efi/EFI/Linux/arch-linux-fallback.efi"|' /mnt/etc/mkinitcpio.d/linux.preset
sed -i '/^default_image=/d' /mnt/etc/mkinitcpio.d/linux.preset
sed -i '/^fallback_image=/d' /mnt/etc/mkinitcpio.d/linux.preset
rm -rf /mnt/efi/EFI/Linux
mkdir -p /mnt/efi/EFI/Linux
rm /mnt/boot/*.img

# Register UKI in BIOS
efibootmgr --create --disk $uefi_disk --part $uefi_part_number --label "Arch Linux" --loader '\EFI\Linux\arch-linux.efi' --unicode
efibootmgr --create --disk $uefi_disk --part $uefi_part_number --label "Arch Linux (fallback)" --loader '\EFI\Linux\arch-linux-fallback.efi' --unicode
newboot=$(efibootmgr | grep "Arch Linux" | sed -n 's/Boot\([0-9A-Fa-f]*\).*/\1/p')
efibootmgr -o ${newboot}

# Set hostname
if [ "$is_laptop" == "Y" ]; then
    echo amg-laptop >> /mnt/etc/hostname
else
    echo amg-pc >> /mnt/etc/hostname
fi

# Autologin
mkdir -p /mnt/etc/systemd/system/getty@tty1.service.d
cat > /mnt/etc/systemd/system/getty@tty1.service.d/override.conf <<EOF
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin amg --noclear %I \$TERM
EOF

# DNS
cat > /mnt/etc/NetworkManager/conf.d/dns.conf <<EOF
[main]
dns=none
systemd-resolved=false
EOF
rm /mnt/etc/resolv.conf
cat > /mnt/etc/resolv.conf <<EOF
nameserver 1.1.1.1
EOF

arch-chroot /mnt /bin/bash <<EOF
ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime
hwclock --systohc
locale-gen

systemctl enable NetworkManager
systemctl enable bluetooth

sbctl create-keys
sbctl enroll-keys -m
mkinitcpio -P

chattr +i /etc/resolv.conf

passwd -l root
useradd -m -G wheel -s /bin/bash amg
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
echo 'Defaults timestamp_timeout=0' | tee -a /etc/sudoers

mkdir -p /home/amg/.config
git clone https://github.com/amgdev9/terminal-config /home/amg/.config/terminal-config
env HOME=/home/amg /home/amg/.config/terminal-config/setup-symlinks.sh

mkdir -p /home/amg/AUR
git clone https://aur.archlinux.org/brave-bin.git /home/amg/AUR/brave-bin

chown -R amg:amg /home/amg
sudo -u amg git lfs install
EOF

# Set user password
echo "amg:$amg_passwd" | arch-chroot /mnt chpasswd

# Mask TPM if laptop
if [ "$is_laptop" == "Y" ]; then
    arch-chroot /mnt /bin/bash -c "systemctl mask dev-tpmrm0.device"
fi

# Install nvidia drivers if amg-pc
if [ "$is_laptop" != "Y" ]; then
    arch-chroot /mnt /bin/bash -c "pacman -S nvidia-open nvidia-utils"
fi

echo "Done! Rebooting..."
reboot
