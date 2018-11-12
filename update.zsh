#!/usr/local/bin/zsh

if [[ `uname` == "Linux" ]]; then
  sudo pacman -Syu
fi

if [[ `uname` == "Darwin" ]]; then
  # update App Store apps
  sudo softwareupdate -i -a

  # update Homebrew (Cask) & packages
  brew update
  brew upgrade
  brew cask upgrade
fi

# update npm & packages
if [[ `uname` == "Linux" ]]; then
  . /usr/share/nvm/init-nvm.sh
fi
if [[ `uname` == "Darwin" ]]; then
  # see output of `brew info nvm` for details
  export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"
fi

npm install npm -g
npm update -g

# update Ruby & gems
eval "$(rbenv init -)"
rbenv global default
gem update —-system
gem update
rbenv rehash

# update haskell
stack upgrade
stack update
cabal new-update

# update zsh plugins
. ~/.zsh/plugins
zplug update

# update vim plugins
nvim -u ~/.config/nvim/init.vim +PlugUpdate +PlugClean! +qa
