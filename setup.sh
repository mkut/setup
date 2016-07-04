#!/bin/bash

PREFIX=$HOME
SOURCE=`pwd`

setup_link() {
	if [ -e "$PREFIX/$1" ]
	then
		printf "'$1' already exists!\nback up and replace? (y/[n]) "
		read COMMAND
		if [ "$COMMAND" == "y" ]
		then
			mv $PREFIX/$1 $PREFIX/$1.bak
			ln -s $SOURCE/$1 $PREFIX/$1
			printf "[link] $1\n"
		fi
	else
		ln -s $SOURCE/$1 $PREFIX/$1
		printf "[link] $1\n"
	fi
}

## setup settings for zsh
setup_link .zshrc

mkdir -p ~/.zshrc.d
touch ~/.zshrc.d/local.zsh

## setup settings for vim
setup_link .vimrc
setup_link .vim

mkdir -p ~/.vimrc.d
touch ~/.vimrc.d/local.vim

## link settings for tmux
setup_link .tmux.conf

## setup terminfo
printf "update terminfo? (y/[n]): "
read COMMAND
if [ "$COMMAND" == "y" ]
then
	tic .termcap
	printf "[tic] .terminfo"
fi

