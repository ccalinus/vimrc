#!/bin/bash
# vim: set ts=4 et sw=4 :
#
# update_submodules.sh
#
# Copyright (C) 2016 Calin Copos <calin.copos@windriver.com>
# Distributed under terms of the GPLv2 license.
#
(
    cd ${HOME}/.vim
    source ./pathogen.sh
    pathogen_plugins_update
)
