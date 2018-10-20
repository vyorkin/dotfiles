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

        # install rust
        curl https://sh.rustup.rs -sSf | sh
        source $HOME/.cargo/env
        rustup component add rust-src
        rustup toolchain add nightly
        cargo install bingrep
        cargo install rusty-tags
        rustup component add rustfmt-preview --toolchain nightly
        cargo +nightly install racer

        sudo easy_install pip

        mkdir -p ~/.karabiner.d/configuration/
        touch $HOME/.karabiner.d/configuration/karabiner.json

        sudo sysctl -w kern.maxfiles=1000000
        sudo sysctl -w kern.maxfilesperproc=18000

        defaults write com.apple.finder AppleShowAllFiles YES   # display hidden files in Finder
fi

# manual linking
ln -s $HOME/.dotfiles/rcrc $HOME/.rcrc # ?
ln -s $HOME/.dotfiles/dotsecrets/netrc ~/.netrc
ln -s $HOME/.dotfiles/dotsecrets/ssh ~/.ssh

# link docker bash & zsh completions
if [[ `uname` == "Darwin" ]]; then
  ln -s /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion /usr/local/etc/bash_completion.d/docker
  ln -s /Applications/Docker.app/Contents/Resources/etc/docker-machine.bash-completion /usr/local/etc/bash_completion.d/docker-machine
  ln -s /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion /usr/local/etc/bash_completion.d/docker-compose

  ln -s /Applications/Docker.app/Contents/Resources/etc/docker.zsh-completion /usr/local/share/zsh/site-functions/_docker
  ln -s /Applications/Docker.app/Contents/Resources/etc/docker-machine.zsh-completion /usr/local/share/zsh/site-functions/_docker-machine
  ln -s /Applications/Docker.app/Contents/Resources/etc/docker-compose.zsh-completion /usr/local/share/zsh/site-functions/_docker-compose
fi

# allow apps from unidentified developers
sudo spctl --master-disable

# set zsh as a default shell for the current user
sudo chsh -s $(which zsh) $USER

# backup existing emacs configuration
mv -f $HOME/.emacs.d $HOME/.emacs.d.bak

pip install -r requirements.txt
pip3 install -r requirements3.txt

/usr/local/opt/fzf/install
