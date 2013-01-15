# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/goaccess/goaccess-0.5-r1.ebuild,v 1.1 2013/01/15 11:32:30 pinkbyte Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=1
inherit autotools-utils

DESCRIPTION="A real-time Apache log analyzer and interactive viewer that runs in a terminal"
HOMEPAGE="http://goaccess.prosoftcorp.com"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE="geoip unicode"

RDEPEND="
	dev-libs/glib:2
	sys-libs/ncurses[unicode?]
	geoip? ( dev-libs/geoip )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

src_prepare() {
	# respect CFLAGS, bug #451806
	sed -i -e '/AM_CFLAGS/s/-g//' Makefile.am || die 'sed failed'
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		$(use_enable geoip)
		$(use_enable unicode utf8)
	)
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile CFLAGS="${CFLAGS}"
}
