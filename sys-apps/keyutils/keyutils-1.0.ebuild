# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/keyutils/keyutils-1.0.ebuild,v 1.1 2005/12/15 00:16:58 robbat2 Exp $

DESCRIPTION="Linux Key Management Utilities"
HOMEPAGE="http://www.kernel.org/"
SRC_URI="http://people.redhat.com/~dhowells/${PN}/${P}.tar.bz2"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=sys-kernel/linux-headers-2.6.11"
#RDEPEND=""

src_compile() {
	make CFLAGS="-Wall ${CFLAGS}"
}

src_install() {
	emake install DESTDIR="${D}"
	dodoc README
}
