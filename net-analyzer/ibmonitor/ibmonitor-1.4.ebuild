# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ibmonitor/ibmonitor-1.4.ebuild,v 1.2 2007/03/20 14:17:24 armin76 Exp $

DESCRIPTION="Interactive bandwidth monitor"
HOMEPAGE="http://ibmonitor.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${PV}.tar.gz"

KEYWORDS="~amd64 ~hppa ~ppc x86"
IUSE=""

LICENSE="GPL-2"
SLOT="0"

S="${WORKDIR}/${PN}"

DEPEND="dev-perl/TermReadKey"

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	dodir /usr/bin
	dobin ibmonitor

	dodoc AUTHORS ChangeLog README TODO
}
