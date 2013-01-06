# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/libinklevel/libinklevel-0.7.1.ebuild,v 1.2 2007/07/13 07:15:13 mr_bones_ Exp $

inherit eutils multilib

DESCRIPTION="A library to get the ink level of your printer"
HOMEPAGE="http://libinklevel.sourceforge.net/"
SRC_URI="mirror://sourceforge/libinklevel/${P/_}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
LICENSE="GPL-2"
IUSE=""

DEPEND="sys-libs/libieee1284"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-libdir.patch
}

src_install () {
	emake DESTDIR=${D}/usr LIBDIR=$(get_libdir) install || \
		die "emake install failed"
	dodoc README
}
