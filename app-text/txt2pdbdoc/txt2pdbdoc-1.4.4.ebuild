# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/txt2pdbdoc/txt2pdbdoc-1.4.4.ebuild,v 1.9 2009/01/03 00:40:35 angelos Exp $

inherit autotools

DESCRIPTION="Text/HTML to Doc file converter for the Palm Pilot"
HOMEPAGE="http://homepage.mac.com/pauljlucas/software/txt2pdbdoc/"
SRC_URI="http://homepage.mac.com/pauljlucas/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND="dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "/^CFLAGS/d" configure.in
	eautoreconf
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README ChangeLog
}
