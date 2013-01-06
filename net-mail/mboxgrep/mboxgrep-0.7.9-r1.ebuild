# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mboxgrep/mboxgrep-0.7.9-r1.ebuild,v 1.5 2012/12/21 13:39:38 eras Exp $

EAPI=4

inherit eutils

DESCRIPTION="Grep for mbox files"
SRC_URI="mirror://sourceforge/mboxgrep/${P}.tar.gz"
HOMEPAGE="http://mboxgrep.sf.net"

DEPEND=""
RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="GPL-2+"
KEYWORDS="ppc x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-ldflags.patch
}

src_install () {
	emake \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install
	dodoc ChangeLog NEWS TODO README
}
