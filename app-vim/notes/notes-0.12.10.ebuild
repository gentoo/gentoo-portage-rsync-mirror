# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/notes/notes-0.12.10.ebuild,v 1.1 2011/11/17 16:33:23 radhermit Exp $

EAPI=4

inherit vim-plugin

DESCRIPTION="vim plugin: easy note taking in vim"
HOMEPAGE="http://peterodding.com/code/vim/notes/"
SRC_URI="https://github.com/xolox/vim-${PN}/tarball/${PV} -> ${P}.tar.gz"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-vim/xolox-misc-20110926
	|| ( dev-lang/python:2.7[sqlite] dev-lang/python:2.6[sqlite] )"

VIM_PLUGIN_HELPFILES="${PN}.txt"

src_unpack() {
	unpack ${A}
	mv *-${PN}-* "${S}"
}

src_prepare() {
	# Remove unnecessary files
	rm INSTALL.md README.md misc/notes/user/README || die
	rm -r autoload/xolox/misc || die
}
