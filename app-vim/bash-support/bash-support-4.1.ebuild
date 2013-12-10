# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/bash-support/bash-support-4.1.ebuild,v 1.1 2013/12/10 07:24:59 radhermit Exp $

EAPI=5

inherit vim-plugin

DESCRIPTION="vim plugin: Bash-IDE - Write and run bash scripts using menus and hotkeys"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=365"
LICENSE="public-domain"
KEYWORDS="~amd64 ~x86"

VIM_PLUGIN_HELPFILES="${PN}"

src_install() {
	dodoc ${PN}/doc/{ChangeLog,bash-hotkeys.pdf}
	rm -rf ${PN}/doc

	vim-plugin_src_install
}
