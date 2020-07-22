# manual linking
ln -sf $HOME/.dotfiles/rcrc ~/.rcrc
ln -sf $HOME/.dotfiles/dotsecrets/authinfo ~/.authinfo
ln -sf $HOME/.dotfiles/dotsecrets/netrc ~/.netrc
ln -sf $HOME/.dotfiles/dotsecrets/ssh ~/.ssh
ln -sf $HOME/.dotfiles/dotsecrets/offlineimaprc ~/.offlineimaprc
ln -sf $HOME/.dotfiles/dotsecrets/goobookrc ~/.goobookrc
ln -sf $HOME/.dotfiles/dotsecrets/goobook_auth.json ~/.goobook_auth.json

if [[ `uname` == "Darwin" ]]; then
  source ./setup-macos.sh
fi
