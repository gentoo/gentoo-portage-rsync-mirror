# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/fugitive/fugitive-9999.ebuild,v 1.1 2014/06/19 05:32:13 radhermit Exp $

EAPI=5

inherit vim-plugin git-r3

EGIT_REPO_URI="git://github.com/tpope/vim-fugitive.git"

DESCRIPTION="vim plugin: a git wrapper for vim"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=2975 https://github.com/tpope/vim-fugitive/"
LICENSE="vim"

VIM_PLUGIN_HELPFILES="${PN}.txt"

RDEPEND="dev-vcs/git"
