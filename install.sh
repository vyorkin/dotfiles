#!/bin/sh

if [[ `uname -r` == *"ARCH" ]]; then
        sudo pacman -Syu
        echo '
        [archlinuxfr]
        SigLevel = Never
        Server = http://repo.archlinux.fr/$arch
        ' >> /etc/pacman.conf
        sudo pacman -Sy yaourt
        sed -e '/^$/q' tag-linux/arch/$(hostname).pacmanity | sudo pacman -S -
fi

if [[ `uname` == "Darwin" ]]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        brew tap homebrew/bundle
        brew bundle

        xcode-select --install

        # setup agda
        mkdir -p ~/.agda
        echo /usr/local/lib/agda/standard-library.agda-lib >>~/.agda/libraries
        echo standard-library >>~/.agda/defaults

        # install rust
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        source ~/.cargo/env
        rustup toolchain add nightly
        rustup default nightly
        rustup component add rust-src
        cargo install bingrep
        cargo install rusty-tags
        # rustup component add rustfmt-preview --toolchain nightly
        cargo +nightly install racer

        sudo easy_install pip

        # update the Hackage index for the first time
        cabal update

        mkdir -p ~/.karabiner.d/configuration/
        touch ~/.karabiner.d/configuration/karabiner.json
fi

# install nix
curl https://nixos.org/nix/install | sh
# init nix
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
  . ~/.nix-profile/etc/profile.d/nix.sh
fi
# install packages
nix-env --install cabal2nix
nix-env --install nix-prefetch-git
nix-env --install cabal-install

# manual linking
source symlink.sh

# fix key permissions
chmod 600 ~/.ssh/id_*

# allow apps from unidentified developers
sudo spctl --master-disable

# set zsh as a default shell for the current user
sudo chsh -s $(which zsh) $USER

# backup existing emacs configuration
mv -f ~/.emacs.d ~/.emacs.d.bak

python3 -m pip install --user --upgrade pynvim
pip install -r requirements.txt
pip3 install -r requirements3.txt

/usr/local/opt/fzf/install

# install ocaml packages
# switch to older ocamlc since
# Reasonml and Bucklescript use an older version of ocaml
opam switch create 4.02.3
opam init
opam install merlin tuareg utop reason
# fstar
opam pin add fstar --dev-repo
opam install fstar

rcup -v -d ~/.dotfiles

if [[ `uname` == "Darwin" ]]; then
  rcup -v -t macos -d ~/.dotfiles
elif [[ `uname` == "Linux" ]]; then
  rcup -v -t linux -d ~/.dotfiles
fi
