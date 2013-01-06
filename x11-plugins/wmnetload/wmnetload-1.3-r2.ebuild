# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmnetload/wmnetload-1.3-r2.ebuild,v 1.6 2012/03/18 19:56:30 armin76 Exp $

inherit eutils

DESCRIPTION="Network interface monitor dockapp"
HOMEPAGE="http://freshmeat.net/projects/wmnetload/"
SRC_URI="ftp://truffula.com/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

DEPEND="x11-libs/libdockapp"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Add support for libdockapp 0.5
	epatch "${FILESDIR}"/add_support_for_libdockapp_0.5.patch

	epatch "${FILESDIR}"/wmnetload-1.3-norpath.patch
}

src_install() {
	einstall || die "einstall failed."
	dodoc AUTHORS README NEWS
}
