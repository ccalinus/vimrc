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


References
----------
	[1] http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/
	[2] http://jirichara.com/manage-your-vim-plugins-using-pathogen-and-git-submodules


Development
-----------


plugin_remove()
{
	plugin $1
	git submodule deinit -f bundle/$plugin
	git rm  -rf bundle/$plugin

}

plugin_add()
{
	url=$
	plugin=${url
	git submodule add $url bundle/$plugin
}


