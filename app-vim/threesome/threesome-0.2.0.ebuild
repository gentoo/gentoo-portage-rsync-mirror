# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/threesome/threesome-0.2.0.ebuild,v 1.1 2011/09/19 06:45:50 radhermit Exp $

EAPI="4"
VIM_PLUGIN_VIM_VERSION="7.3"

inherit vim-plugin

MY_PN="Threesome"
DESCRIPTION="vim plugin: resolve conflicts during three-way merges"
HOMEPAGE="http://sjl.bitbucket.org/threesome.vim/"
SRC_URI="https://github.com/vim-scripts/${MY_PN}/tarball/${PV} -> ${P}.tar.gz"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| ( app-editors/vim[python] app-editors/gvim[python] )
	>=dev-lang/python-2.5"

VIM_PLUGIN_HELPFILES="${PN}.txt"

src_unpack() {
	unpack ${A}
	mv *-${MY_PN}-* "${S}"
}

src_prepare() {
	rm README* LICENSE || die
}
