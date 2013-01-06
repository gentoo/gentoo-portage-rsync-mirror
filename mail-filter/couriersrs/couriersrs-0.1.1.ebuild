# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/couriersrs/couriersrs-0.1.1.ebuild,v 1.1 2009/09/29 23:07:37 hanno Exp $

inherit autotools eutils

DESCRIPTION="SRS (Sender Rewriting Scheme) wrapper for the courier MTA."
HOMEPAGE="http://couriersrs.com/"
SRC_URI="http://couriersrs.com/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
DEPEND="dev-libs/popt
	mail-filter/libsrs2"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm `grep -l gettext m4/*.m4`
	epatch "${FILESDIR}/${P}-libtool-automake-fixes.diff"
	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS ChangeLog
}
