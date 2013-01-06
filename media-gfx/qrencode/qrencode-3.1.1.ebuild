# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/qrencode/qrencode-3.1.1.ebuild,v 1.12 2012/05/05 07:00:20 jdhore Exp $

EAPI=2

inherit autotools eutils

DESCRIPTION="C library for encoding data in a QR Code symbol"
HOMEPAGE="http://fukuchi.org/works/qrencode/"
SRC_URI="http://fukuchi.org/works/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ppc x86"
IUSE=""

RDEPEND="media-libs/libpng"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}/${P}-pngregenfix.patch"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog NEWS README TODO
}
