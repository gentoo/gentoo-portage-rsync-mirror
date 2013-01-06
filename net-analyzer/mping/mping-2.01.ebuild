# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/mping/mping-2.01.ebuild,v 1.7 2006/11/15 12:58:38 corsair Exp $

inherit eutils

DESCRIPTION="IPv4/6 round-robin multiping client"
HOMEPAGE="http://mping.uninett.no"
SRC_URI="http://mping.uninett.no/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-RFC3542.patch
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
