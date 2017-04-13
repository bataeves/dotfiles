#!/usr/bin/env bash
set -x

# Install command line tools.
xcode-select --install

# A full installation of Xcode.app is required to compile some formulas like
# macvim. Installing the Command Line Tools only is not enough.
# Also, if Xcode is installed but the license is not accepted then brew will
# fail.
xcodebuild -version
# Accept Xcode license
if [[ $? -ne 0 ]]; then
    # TODO: find a way to install Xcode.app automatticaly
    # See: https://stackoverflow.com/a/18244349
    sudo xcodebuild -license
fi

# Update all macOS packages
# sudo softwareupdate -i -a

# Install Homebrew if not found
brew --version 2>&1 >/dev/null
if [[ $? -ne 0 ]]; then
    # Clean-up failed Homebrew installs first without prompting the user.
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)" -- "--force"
    # Install Homebrew without prompting for user confirmation.
    # See: https://github.com/Homebrew/install/blob
    # /7ff54f50f73170a51c11b0dda74b663806cb6cef/install#L184
    TRAVIS=true ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew update
brew upgrade

# Include duplicates packages
brew tap homebrew/dupes

# Add Cask
brew tap caskroom/cask

# Add services
brew tap homebrew/services

# Install Bash 4.
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`.
brew install bash
brew tap homebrew/versions
brew install bash-completion2

# Switch to using brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

# Install macOS system requirements
brew cask install xquartz

# Install a brand new Python
# brew install python
# brew link --overwrite python
# Install python 3 too.
brew install python3

# Install common packages
brew install apple-gcc42
for PACKAGE in $COMMON_PACKAGES
do
   brew install "$PACKAGE"
done
brew install vim
brew link --force vim
brew install ack
brew install cassandra
brew install curl
brew link --force curl
brew install dockutil
brew install exiftool
brew install faad2
brew install gpg-agent
brew install md5sha1sum
brew install openssl
brew install osxutils
brew install pstree
brew install rmlint
brew install rclone
brew install ssh-copy-id
brew install watch

# htop-osx requires root privileges to correctly display all running processes.
brew link --overwrite htop-osx
sudo chown root:wheel "$(brew --prefix)/bin/htop"
sudo chmod u+s "$(brew --prefix)/bin/htop"

# Install binary apps from homebrew.
for PACKAGE in $BIN_PACKAGES
do
   brew cask install "$PACKAGE"
done
brew cask install gitup
brew cask install java
# brew cask install keybase
# brew cask install libreoffice
brew cask install spectacle
brew cask install telegram-desktop
brew cask install torbrowser
brew cask install tunnelblick


# Install QuickLooks plugins
# Source: https://github.com/sindresorhus/quick-look-plugins
brew cask install epubquicklook
brew cask install qlcolorcode
brew cask install qlimagesize
brew cask install qlmarkdown
brew cask install qlstephen
brew cask install qlvideo
brew cask install quicklook-json
brew cask install qlprettypatch
brew cask install quicklook-csv
brew cask install betterzipql
brew cask install suspicious-package
qlmanage -r

# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

# Install more recent versions of some macOS tools.
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh

# Add extra filesystem support.
brew cask install osxfuse
brew install homebrew/fuse/ext2fuse
brew install homebrew/fuse/ext4fuse
brew install homebrew/fuse/ntfs-3g


brew cask install sublime-text
mkdir -p "~/Library/Application Support/Sublime Text 3/Packages/User/"
mkdir -p "~/Library/Application Support/Sublime Text 3/Installed Packages"
mkdir -p ~/.local/bin/
wget "https://packagecontrol.io/Package%20Control.sublime-package" -O "~/Library/Application Support/Sublime Text 3/Installed Packages/Package Control.sublime-package"
cp "dotfiles-common/Package Control.sublime-settings" "~/Library/Application Support/Sublime Text 3/Packages/User/Package Control.sublime-settings"
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ~/.local/bin/subl

# Clean things up.
brew linkapps
brew cleanup
brew prune
brew cask cleanup
