# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sfftobmp/sfftobmp-3.1.1.ebuild,v 1.7 2011/08/04 10:09:35 hwoarang Exp $

EAPI=2
inherit autotools eutils flag-o-matic

MY_P=${PN}${PV//./_}

DESCRIPTION="sff to bmp converter"
HOMEPAGE="http://sfftools.sourceforge.net/"
SRC_URI="mirror://sourceforge/sfftools/${MY_P}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc x86"
IUSE=""

RDEPEND="dev-libs/boost
	media-libs/tiff
	virtual/jpeg"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${MY_P}

src_prepare() {
	append-flags -DBOOST_FILESYSTEM_VERSION=2
	epatch "${FILESDIR}"/${P}-gcc43-and-cerrno.patch \
		"${FILESDIR}"/${P}-gcc44-and-boost-1_37.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc doc/{changes,credits,readme}
}
