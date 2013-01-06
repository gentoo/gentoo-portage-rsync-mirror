# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/bash-support/bash-support-3.8.ebuild,v 1.1 2011/12/04 19:58:07 radhermit Exp $

EAPI=4

inherit vim-plugin

MY_PN="bash-support.vim"
DESCRIPTION="vim plugin: Bash-IDE - Write and run bash scripts using menus and hotkeys"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=365"
SRC_URI="https://github.com/vim-scripts/${MY_PN}/tarball/${PV} -> ${P}.tar.gz"
LICENSE="public-domain"
KEYWORDS="~amd64 ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="${PN}.txt"

src_unpack() {
	unpack ${A}
	mv *-${MY_PN}-* "${S}"
}

src_prepare() {
	# Remove unnecessary files
	rm README* || die
}

src_install() {
	dodoc doc/{ChangeLog,bash-hot-keys.pdf}
	rm -rf doc/{ChangeLog,bash-hot-keys.*}

	vim-plugin_src_install
}
