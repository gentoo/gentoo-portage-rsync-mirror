# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/tagbar/tagbar-2.2.ebuild,v 1.1 2011/12/04 20:25:41 radhermit Exp $

EAPI="4"

inherit vim-plugin

DESCRIPTION="vim plugin: display tags of the current file ordered by scope"
HOMEPAGE="http://majutsushi.github.com/tagbar/
	http://www.vim.org/scripts/script.php?script_id=3465"
SRC_URI="http://github.com/majutsushi/${PN}/tarball/v${PV} -> ${P}.tar.gz"
LICENSE="vim"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-util/ctags-5.5"

VIM_PLUGIN_HELPFILES="${PN}.txt"

src_unpack() {
	unpack ${A}
	mv *-${PN}-* "${S}"
}
