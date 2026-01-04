/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install bash htop neovim rclone tmux wget watch podman

./push.sh

# XCode specific packages
brew install cocoapods fastlane xcbeautify node@25

echo "Done, install XCode to finish"
