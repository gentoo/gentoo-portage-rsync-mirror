# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/starparse/starparse-1.0-r1.ebuild,v 1.3 2012/07/26 08:37:31 jlec Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=yes

inherit autotools-utils

DESCRIPTION="Library for parsing NMR star files (peak-list format) and CIF files"
HOMEPAGE="http://burrow-owl.sourceforge.net/"
#SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
# Created from rev 19 @ http://oregonstate.edu/~benisong/software/projects/starparse/releases/1.0
SRC_URI="http://dev.gentooexperimental.org/~jlec/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="guile static-libs"

RDEPEND="guile? ( dev-scheme/guile )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}"/${P}-guile1.8.patch )

src_configure() {
	local myeconfargs=( $(use_enable guile) )
	autotools-utils_src_configure
}

src_test() {
	if use guile; then
		autotools-utils_src_test
	else
		ewarn "Skipping tests because USE guile is disabled"
	fi
}
