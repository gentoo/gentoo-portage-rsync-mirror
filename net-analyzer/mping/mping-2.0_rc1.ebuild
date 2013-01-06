# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/mping/mping-2.0_rc1.ebuild,v 1.10 2006/01/10 00:07:37 vapier Exp $

DESCRIPTION="IPv4/6 round-robin multiping client"
HOMEPAGE="http://mping.uninett.no"
SRC_URI="http://mping.uninett.no/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ppc64 sparc x86"
IUSE=""

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
