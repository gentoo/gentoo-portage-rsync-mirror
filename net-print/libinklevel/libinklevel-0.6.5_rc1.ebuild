# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/libinklevel/libinklevel-0.6.5_rc1.ebuild,v 1.5 2007/07/13 07:15:13 mr_bones_ Exp $

inherit multilib eutils

DESCRIPTION="A library to get the ink level of your printer"
HOMEPAGE="http://libinklevel.sourceforge.net/"
SRC_URI="mirror://sourceforge/libinklevel/${P/_}.tar.gz"

SLOT="0"
KEYWORDS="amd64 ~ppc x86"
LICENSE="GPL-2"
IUSE=""

DEPEND="sys-libs/libieee1284"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}"/${P}-libdir.patch || die "applying patch failed"
}

src_install () {
	make DESTDIR=${D}/usr LIBDIR="\$(DESTDIR)/$(get_libdir)" install || die "make install failed"
	dodoc README
}
