# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/align/align-43.ebuild,v 1.2 2013/12/12 12:39:50 nimiux Exp $

EAPI=5

inherit vim-plugin

DESCRIPTION="vim plugin: commands and maps to help produce aligned text"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=294"
LICENSE="vim"
KEYWORDS="~alpha amd64 ~ia64 ~mips ~ppc ~sparc ~x86"

RDEPEND="app-vim/cecutil"

VIM_PLUGIN_HELPFILES="align"
