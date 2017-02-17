vimrc: VIM resources
=====================

Installation
------------

Perform these commands:

.. code-block:: bash

    $ git clone --recursive git@github.com:ccalinus/vimrc.git ~/.vim
    $ ln -s ~/.vim/vimrc ~/.vimrc
    $ ln -s ~/.vim/gvimrc ~/.gvimrc
    $ cd ~/.vim
    $ git submodule init
    $ git submodule update --recursive

or

.. code-block:: bash

    $ source pathogen.sh
    $ pathogen_setup

when the workflow is supported.

References
----------

.. [1] `Synchronizing plugins with git submodules and pathogen <http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen>`__
.. [2] `Manage your vim plugins using pathogen and git submodules <http://jirichara.com/manage-your-vim-plugins-using-pathogen-and-git-submodules>`__


