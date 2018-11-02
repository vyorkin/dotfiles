install:
	./install.sh

up:
	rcup -v -d ~/.dotfiles

down:
	rcdn -v -d ~/.dotfiles

.PHONY: install up down
