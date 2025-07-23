{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  # Will be overwritten by the UKI generation script but we need one bootloader setup
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 1;
  boot.loader.timeout = 0;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  # NetworkManager
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" ]; # Cloudflare DNS
  networking.networkmanager.dns = "none";
  
  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
 
  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "es";
  };
  
  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Power management
  services.upower.enable = true;

  # Linker for non nixos programs
  programs.nix-ld.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.amg = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" ];
  };

  # Asks for password on sudo every time
  security.sudo.extraConfig = ''
    Defaults timestamp_timeout=0
  '';

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
     neovim
     tmux
     htop
     gh
     rclone
     brave
     alacritty
     curl
     waybar
     grim
     wofi
     ripgrep
     wl-clipboard
     swaybg
     file
     brightnessctl
     adwaita-icon-theme
     sbctl
     jq
     buildPackages.systemdUkify
     efibootmgr
  ];

  # Git
  programs.git = {
    enable = true;
    prompt = {
      enable = true;
    };
    lfs = {
      enable = true;
    };
  };

  # Autologin
  services.getty = {
    autologinUser = "amg";
    autologinOnce = true;
  };

  # Hyprland
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;
  programs.uwsm.enable = true;
  programs.hyprlock.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];
    
  # Disable firewall
  networking.firewall.enable = false;

  # Increase it only when there is a new version and you want to migrate config (for new features)
  # Having it lower than nixos version is normal, does not mean it is not updated
  system.stateVersion = "25.05";
}

