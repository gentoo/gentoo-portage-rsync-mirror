# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/yasat/yasat-456.ebuild,v 1.1 2012/01/08 13:53:51 hwoarang Exp $

DESCRIPTION="Security and system auditing tool"
HOMEPAGE="http://yasat.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

S=${WORKDIR}/${PN}

src_install() {
	emake install DESTDIR="${D}" PREFIX="/usr" SYSCONFDIR="/etc" || die
	dodoc README CHANGELOG || die
}
