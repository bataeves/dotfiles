#!/usr/bin/env bash
set -x

# We need to distinguish sources and binary packages for Brew & Cask on macOS
COMMON_PACKAGES="
apg
bash
bash-completion2
colordiff
colortail
coreutils
fdupes
findutils
fontforge
git-extras
gpg
graphviz
grc
hfsutils
htop
atop
imagemagick
jq
jnettop
lame
legit
p7zip
pngcrush
recode
rtmpdump
shellcheck
shntool
testdisk
tree
unrar
wget
"

BIN_PACKAGES=""

# Detect platform.
if [ "$(uname -s)" == "Darwin" ]; then
    IS_MACOS=true
else
    IS_MACOS=false
fi

IS_DESKTOP=$IS_MACOS

if $IS_MACOS; then
    # Ask for the administrator password upfront.
    sudo -v
    # Keep-alive: update existing `sudo` time stamp until script has finished.
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
fi

# Force initialization and update of local submodules.
git submodule init
git submodule update --remote --merge

# Search local dotfiles
if $IS_MACOS; then
    DOT_FILES=$(find ./dotfiles-common -maxdepth 1 \
        -not -path "./dotfiles-common" \
        -not -path "./dotfiles-macos" \
        -not -name "\.DS_Store" -and \
        -not -name "*\.swp" -and \
        -not -name "*~*" )
else
    DOT_FILES=$(find ./dotfiles-common ./dotfiles-linux -maxdepth 1 \
        -not -path "./dotfiles-common" \
        -not -path "./dotfiles-linux" \
        -not -name "\.DS_Store" -and \
        -not -name "*\.swp" -and \
        -not -name "*~*" )
fi

for FILEPATH in $DOT_FILES
do
    SOURCE="${PWD}/$FILEPATH"
    TARGET="${HOME}/$(basename "${FILEPATH}")"
    if [ "$1" = "restore" ]; then
        # Restore backups if found
        if [ -e "${TARGET}.dotfiles.bak" ] && [ -L "${TARGET}" ]; then
            unlink "${TARGET}"
            mv "$TARGET.dotfiles.bak" "$TARGET"
        fi
    else
        # Link files
        if [ -e "${TARGET}" ] && [ ! -L "${TARGET}" ]; then
            mv "$TARGET" "$TARGET.dotfiles.bak"
        fi
        ln -sf "${SOURCE}" "$(dirname "${TARGET}")"
    fi
done

# Install vim plugins

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/installer.sh
# mkdir -p ~/.vim/dein/
# sh /tmp/installer.sh ~/.vim/dein/

# Install all software first.
if $IS_MACOS; then
    source ./scripts/macos-install.sh
    source ./scripts/macos-install-refind.sh
# else
#     source ./scripts/kubuntu-install.sh
fi

# Install & upgrade all global python modules
PYTHON_PACKAGES="
pip
readline
bumpversion
gmvault
gsutil
httpie
ipython
pygments
setuptools
virtualenv
virtualenvwrapper
"
for p in $PYTHON_PACKAGES
do
    pip install --user --upgrade "$p"
done

# Patch terminal font for Vim's Airline plugin
# See: https://powerline.readthedocs.org/en/latest/fontpatching.html
mkdir ./powerline-fontpatcher
curl -fsSL https://github.com/Lokaltog/powerline-fontpatcher/tarball/develop | tar -xvz --strip-components 1 --directory ./powerline-fontpatcher -f -
fontforge -script ./powerline-fontpatcher/scripts/powerline-fontpatcher --no-rename ./assets/SourceCodePro-Regular.otf
rm -rf ./powerline-fontpatcher
# Install the patched font
if $IS_MACOS; then
    mkdir -p ~/Library/Fonts/
    mv ./Source\ Code\ Pro.otf ~/Library/Fonts/
else
    mkdir -p ~/.fonts/
    mv ./Source\ Code\ Pro.otf ~/.fonts/
    # Refresh font cache
    fc-cache -f -v
fi

mkdir -p ~/.vim/colors/
cp ~/.vim/dein/repos/github.com/dracula/vim/colors/dracula.vim ~/.vim/colors/
cp ~/.vim/dein/repos/github.com/altercation/vim-colors-solarized/colors/solarized.vim ~/.vim/colors/
mkdir -p ~/.vim_tmp/
vim -c ':call dein#install()'

# Configure everything.
# if $IS_MACOS; then
    # source ./scripts/macos-config.sh
# fi

cp ~/.ssh.dotfiles.bak/* ~/.ssh/

# Reload Bash with new configuration
source ~/.bash_profile
