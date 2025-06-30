# Installation
- Install submodules with `git submodule update --init --recursive`
- Run `setup-symlinks.sh` to install user dotfiles
- Run `update-nixos` to update nixos config and rebuild the system

# Credentials setup
- sudo passwd -l root
- sudo sbctl create-keys
- Once updated, enroll the secure boot keys
