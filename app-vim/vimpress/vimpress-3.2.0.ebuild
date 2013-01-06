# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/vimpress/vimpress-3.2.0.ebuild,v 1.3 2012/12/04 11:23:31 ago Exp $

EAPI=4

inherit vim-plugin

DESCRIPTION="vim plugin: manage wordpress blogs from vim"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=3510"
LICENSE="vim"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="|| ( app-editors/vim[python] app-editors/gvim[python] )
	|| ( dev-lang/python:2.7 dev-lang/python:2.6 )
	dev-python/markdown"

VIM_PLUGIN_HELPFILES="${PN}.txt"
