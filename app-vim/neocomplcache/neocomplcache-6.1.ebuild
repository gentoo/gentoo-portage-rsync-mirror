# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/neocomplcache/neocomplcache-6.1.ebuild,v 1.1 2011/09/14 22:40:44 radhermit Exp $

EAPI=4

inherit vim-plugin

DESCRIPTION="vim plugin: ultimate auto completion system"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=2620"
SRC_URI="https://github.com/vim-scripts/${PN}/tarball/${PV} -> ${P}.tar.gz"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="${PN}.txt"

src_unpack() {
	unpack ${A}
	mv *-${PN}-* "${S}"
}

src_prepare() {
	rm README* || die
}
