# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/align/align-42.ebuild,v 1.7 2012/12/30 14:37:51 ago Exp $

EAPI=4

inherit vim-plugin

DESCRIPTION="vim plugin: commands and maps to help produce aligned text"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=294"
LICENSE="vim"
KEYWORDS="alpha amd64 ia64 ~mips ppc sparc x86"
IUSE=""
RDEPEND="app-vim/cecutil"

VIM_PLUGIN_HELPFILES="align"
