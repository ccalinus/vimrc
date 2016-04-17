vimrc: VIM resources
=====

Installation
------------

	git clone --recursive git@github.com:ccalinus/vimrc.git ~/.vim
	ln -s ~/.vim/vimrc ~/.vimrc
	ln -s ~/.vim/gvimrc ~/.gvimrc
	cd ~/.vim
	git submodule init
	git submodule update --recursive

or 

	source pathogen.sh
	pathogen_setup

when the workflow is supported.

References
----------
	[1] http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/
	[2] http://jirichara.com/manage-your-vim-plugins-using-pathogen-and-git-submodules
