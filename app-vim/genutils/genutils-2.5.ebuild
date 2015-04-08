# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/genutils/genutils-2.5.ebuild,v 1.5 2011/01/07 22:22:32 ranger Exp $

EAPI=3

inherit vim-plugin

DESCRIPTION="vim plugin: library with various useful functions"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=197"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=11399 -> ${P}.zip"
LICENSE="GPL-3"
KEYWORDS="alpha amd64 ia64 ~mips ppc sparc x86"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides library functions and is not intended to be used
directly by the user."

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}"
