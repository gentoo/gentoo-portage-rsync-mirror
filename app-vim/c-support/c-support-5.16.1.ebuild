# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/c-support/c-support-5.16.1.ebuild,v 1.1 2011/11/13 20:24:07 radhermit Exp $

EAPI="4"

inherit vim-plugin

MY_PN="c.vim"
DESCRIPTION="vim plugin: C/C++-IDE -- Write and run programs using menus and hotkeys"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=213"
SRC_URI="https://github.com/vim-scripts/${MY_PN}/tarball/${PV} -> ${P}.tar.gz"
LICENSE="public-domain"
KEYWORDS="~amd64 ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="csupport.txt"

src_unpack() {
	unpack ${A}
	mv *-${MY_PN}-* "${S}"
}

src_prepare() {
	rm README* || die
}

src_install() {
	dodoc doc/{ChangeLog,c-hotkeys.pdf}
	rm doc/{ChangeLog,c-hotkeys.*} || die

	vim-plugin_src_install
}
