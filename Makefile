all: setup vim tmux zsh

setup:
	@./script/setup

vim:
	@./script/vim

tmux:
	@./script/tmux

zsh:
	@./script/tmux

.PHONY: setup vim tmux zsh
