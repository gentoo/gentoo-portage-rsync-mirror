# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/c-support/c-support-5.19.ebuild,v 1.1 2012/08/05 23:40:00 radhermit Exp $

EAPI="4"

inherit vim-plugin

DESCRIPTION="vim plugin: C/C++-IDE -- Write and run programs using menus and hotkeys"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=213"
LICENSE="public-domain"
KEYWORDS="~amd64 ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="csupport.txt"

src_install() {
	dodoc ${PN}/doc/{ChangeLog,c-hotkeys.pdf}
	rm -r ${PN}/doc || die

	vim-plugin_src_install
}
