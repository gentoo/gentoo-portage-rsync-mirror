# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xtscal/xtscal-0.6.3.ebuild,v 1.8 2010/10/21 01:22:52 ranger Exp $

inherit autotools eutils

DESCRIPTION="Touchscreen calibration utility"
HOMEPAGE="http://gpe.linuxtogo.org/"
SRC_URI="http://gpe.linuxtogo.org/download/source/${P}.tar.bz2 mirror://gentoo/xtscal-0.6.3-patches-0.1.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ~ia64 ~m68k ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="x11-libs/libX11 x11-proto/xcalibrateproto x11-libs/libXCalibrate"
RDEPEND="x11-libs/libX11"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/patch/*.patch
	eautoreconf
}

src_install() {
	dobin xtscal || die
}
