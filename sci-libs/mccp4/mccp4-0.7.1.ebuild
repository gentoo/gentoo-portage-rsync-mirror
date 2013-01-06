# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/mccp4/mccp4-0.7.1.ebuild,v 1.5 2008/04/08 07:57:22 dberkholz Exp $

inherit eutils

DESCRIPTION="Mini-CCP4 library including mtz and map I/O"
HOMEPAGE="http://www.ccp4.ac.uk/"
SRC_URI="http://www.ysbl.york.ac.uk/~emsley/software/extras/${P}.tar.gz"
LICENSE="ccp4"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"
RESTRICT="mirror"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/0.7.1-add-amd64-support.patch
}

src_compile() {
	econf \
		--includedir='${prefix}/include/mccp4' \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
}
