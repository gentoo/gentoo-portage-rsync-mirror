# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/libinklevel/libinklevel-0.8.0.ebuild,v 1.1 2009/10/27 21:06:54 bangert Exp $

EAPI="2"

MY_P="${P/_/}"
DESCRIPTION="A library to get the ink level of your printer"
HOMEPAGE="http://libinklevel.sourceforge.net/"
SRC_URI="mirror://sourceforge/libinklevel/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
LICENSE="GPL-2"
IUSE="debug"

DEPEND=">=sys-libs/libieee1284-0.2.11"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_configure() {
	econf $(use_enable debug)
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
	rm "${D}"/usr/lib/libinklevel.la
}
