# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/unix2tcp/unix2tcp-0.7.2.ebuild,v 1.5 2004/06/25 00:17:35 agriffis Exp $

inherit eutils

DESCRIPTION="a connection forwarder that converts Unix sockets into TCP sockets"
HOMEPAGE="http://dizzy.roedu.net/unix2tcp/"
SRC_URI="http://dizzy.roedu.net/unix2tcp/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 s390"
IUSE=""

src_compile() {
	emake LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	dobin unix2tcp
	dodoc ChangeLog README
}
