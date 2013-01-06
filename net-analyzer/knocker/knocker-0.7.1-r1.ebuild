# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/knocker/knocker-0.7.1-r1.ebuild,v 1.6 2012/12/01 19:35:47 armin76 Exp $

inherit eutils

DESCRIPTION="Knocker is an easy to use security port scanner written in C"
SRC_URI="mirror://sourceforge/knocker/${P}.tar.gz"
HOMEPAGE="http://knocker.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.7.1-free.patch
}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die "emake died"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc ChangeLog AUTHORS README BUGS TO-DO NEWS
}
