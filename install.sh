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
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew tap Homebrew/bundle
        brew bundle
        mas signin

        xcode-select --install

        # setup agda
        mkdir -p ~/.agda
        echo /usr/local/lib/agda/standard-library.agda-lib >>~/.agda/libraries
        echo standard-library >>~/.agda/defaults

        # install rust
        curl https://sh.rustup.rs -sSf | sh
        source ~/.cargo/env
        rustup toolchain add nightly
        rustup default nightly
        rustup component add rust-src
        cargo install bingrep
        cargo install rusty-tags
        rustup component add rustfmt-preview --toolchain nightly
        cargo +nightly install racer

        sudo easy_install pip

        # update the Hackage index for the first time
        cabal new-update

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
ln -s $HOME/.dotfiles/rcrc ~/.rcrc
ln -s $HOME/.dotfiles/dotsecrets/authinfo ~/.authinfo
ln -s $HOME/.dotfiles/dotsecrets/netrc ~/.netrc
ln -s $HOME/.dotfiles/dotsecrets/ssh ~/.ssh
ln -s $HOME/.dotfiles/dotsecrets/offlineimaprc ~/.offlineimaprc
ln -s $HOME/.dotfiles/dotsecrets/goobookrc ~/.goobookrc
ln -s $HOME/.dotfiles/dotsecrets/goobook_auth.json ~/.goobook_auth.json

# fix key permissions
chmod 600 ~/.ssh/id_*

# link docker bash & zsh completions
if [[ `uname` == "Darwin" ]]; then
  ln -s /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion /usr/local/etc/bash_completion.d/docker
  ln -s /Applications/Docker.app/Contents/Resources/etc/docker-machine.bash-completion /usr/local/etc/bash_completion.d/docker-machine
  ln -s /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion /usr/local/etc/bash_completion.d/docker-compose

  ln -s /Applications/Docker.app/Contents/Resources/etc/docker.zsh-completion /usr/local/share/zsh/site-functions/_docker
  ln -s /Applications/Docker.app/Contents/Resources/etc/docker-machine.zsh-completion /usr/local/share/zsh/site-functions/_docker-machine
  ln -s /Applications/Docker.app/Contents/Resources/etc/docker-compose.zsh-completion /usr/local/share/zsh/site-functions/_docker-compose

  source ./setup-macos.sh
fi

# allow apps from unidentified developers
sudo spctl --master-disable

# set zsh as a default shell for the current user
sudo chsh -s $(which zsh) $USER

# backup existing emacs configuration
mv -f ~/.emacs.d ~/.emacs.d.bak

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

# install Proof General from GitHub
git clone https://github.com/ProofGeneral/PG ~/.emacs.d/lisp/PG
cd ~/.emacs.d/lisp/PG
make
cd -

rcup -v -d ~/.dotfiles

if [[ `uname` == "Darwin" ]]; then
  rcup -v -t macos -d ~/.dotfiles
elif [[ `uname` == "Linux" ]]; then
  rcup -v -t linux -d ~/.dotfiles
fi
