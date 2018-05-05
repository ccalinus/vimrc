#!/bin/sh
#
# pathogen.sh
#
# Copyright (C) 2015 Calin Copos <calin.copos@windriver.com>
# Distributed under terms of the GPLv2 license.
#

pathogen_setup()
{
	git clone --recursive git@github.com:ccalinus/vimrc.git ~/.vim
	source ~/.vim/workflows.sh
	ln -s ~/.vim/vimrc ~/.vimrc
	ln -s ~/.vim/gvimrc ~/.gvimrc
	cd ~/.vim
	git submodule init
	git submodule update --recursive

}

pathogen_plugins_update()
{
	if [ "$PWD" != "$HOME/.vim" ]; then
		echo "ERROR: the command works only in \"$HOME/.vim\""
		return
	fi
	git submodule update --init --recursive
}

pathogen_plugin_remove()
{
	if [ "$PWD" != "$HOME/.vim" ]; then
		echo "ERROR: the command works only in \"$HOME/.vim\""
		return
	fi
	if [ "$#" != "1" ]; then
		echo "ERROR: function requires one argument"
		return
	fi
	plugin=$1
	if ! grep path .gitmodule | grep "bundle/$plugin"; then
		echo "ERROR: \"bundle/$plugin\" is not a registerd plugin"
		return
	fi
	git submodule deinit -f bundle/$plugin
	git rm  -rf bundle/$plugin

}

pathogen_plugin_add()
{
	if [ "$PWD" != "$HOME/.vim" ]; then
		echo "ERROR: the command works only in \"$HOME/.vim\""
		return
	fi
	if [ "$#" != "1" ]; then
		echo "ERROR: function requires one argument"
		return
	fi
	url=$1
	plugin=${url##*/}
	git submodule add $url bundle/$plugin
}

# The modeline shall be the last line in the script:
# vim: set ts=4 et sw=4 :
