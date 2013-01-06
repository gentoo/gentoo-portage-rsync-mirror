# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/session/session-1.4.22.ebuild,v 1.1 2011/11/17 16:41:39 radhermit Exp $

EAPI=4

inherit vim-plugin

MY_PN="vim-${PN}"
DESCRIPTION="vim plugin: extended session management for vim"
HOMEPAGE="http://peterodding.com/code/vim/session/"
SRC_URI="https://github.com/xolox/${MY_PN}/tarball/${PV} -> ${P}.tar.gz"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="${PN}.txt"

RDEPEND=">=app-vim/xolox-misc-20110926"

src_unpack() {
	unpack ${A}
	mv *-${MY_PN}-* "${S}"
}

src_prepare() {
	# remove unneeded files
	rm *.md || die
	rm -r autoload/xolox/misc || die
}
