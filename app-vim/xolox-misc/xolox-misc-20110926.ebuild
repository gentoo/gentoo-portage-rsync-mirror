# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/xolox-misc/xolox-misc-20110926.ebuild,v 1.1 2011/11/13 20:31:40 radhermit Exp $

EAPI=4

inherit vim-plugin

DESCRIPTION="vim plugin: miscellaneous auto-load scripts"
HOMEPAGE="http://peterodding.com/code/vim/misc/"
SRC_URI="http://dev.gentoo.org/~radhermit/distfiles/${P}.tar.bz2"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_prepare() {
	rm README.md
}
