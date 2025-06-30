# Installation
- Install submodules with `git submodule update --init --recursive`
- Run `setup-symlinks.sh` to install user dotfiles
- Run `update-nixos` to update nixos config and rebuild the system

# Credentials setup
- sudo passwd -l root
- sudo sbctl create-keys
- ... rebuild nixos to sign UKI with created secure boot keys, and put secure boot in setup mode ...
- Use efibootmgr to remove nixos entries and create one pointing to the UKI
- sudo sbctl enroll-keys --microsoft
