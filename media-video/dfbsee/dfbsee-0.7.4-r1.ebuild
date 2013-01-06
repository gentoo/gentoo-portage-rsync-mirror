# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dfbsee/dfbsee-0.7.4-r1.ebuild,v 1.6 2012/05/05 08:58:55 jdhore Exp $

inherit eutils toolchain-funcs

MY_PN="DFBSee"
MY_P=${MY_PN}-${PV}

DESCRIPTION="DFBSee is image viewer and video player based on DirectFB"
SRC_URI="http://www.directfb.org/download/${MY_P}.tar.gz"
HOMEPAGE="http://www.directfb.org/dfbsee.xml"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 -sparc x86"
IUSE=""

RDEPEND=">=dev-libs/DirectFB-0.9.24"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-direcfb-0.9.24.patch"
	epatch "${FILESDIR}/${P}-gcc4.patch"
	epatch "${FILESDIR}/${P}-standardtypes.patch"
	tc-export CC
}

src_install () {
	emake DESTDIR="${D}" install || die
	dodoc README AUTHORS
}
