# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/KXL/KXL-1.1.7-r2.ebuild,v 1.7 2011/03/04 01:29:59 ranger Exp $

EAPI=2
inherit eutils autotools

DESCRIPTION="Development Library for making games for X"
HOMEPAGE="http://kxl.orz.hm/"
SRC_URI="http://kxl.hn.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="x11-libs/libX11"

src_prepare() {
	epatch "${FILESDIR}"/${P}-m4.patch \
		"${FILESDIR}"/${P}-amd64.patch \
		"${FILESDIR}"/${P}-as-needed.patch \
		"${FILESDIR}"/${P}-ldflags.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README
}
