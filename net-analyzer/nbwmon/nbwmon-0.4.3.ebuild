# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nbwmon/nbwmon-0.4.3.ebuild,v 1.2 2014/09/21 08:29:52 ago Exp $

EAPI=5
inherit eutils toolchain-funcs

DESCRIPTION="ncurses bandwidth monitor"
HOMEPAGE="https://github.com/defer-/nbwmon"
SRC_URI="https://github.com/defer-/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="
	sys-libs/ncurses
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

src_prepare() {
	epatch "${FILESDIR}"/${P}-tinfo.patch
	tc-export CC PKG_CONFIG
}
