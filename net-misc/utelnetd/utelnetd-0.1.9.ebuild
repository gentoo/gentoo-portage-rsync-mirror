# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/utelnetd/utelnetd-0.1.9.ebuild,v 1.8 2009/09/23 19:46:41 patrick Exp $

inherit toolchain-funcs

DESCRIPTION="A small Telnet daemon, derived from the Axis tools"
HOMEPAGE="http://www.pengutronix.de/software/utelnetd_en.html"
SRC_URI="http://www.pengutronix.de/software/utelnetd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc s390"
IUSE=""

DEPEND=""

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	dosbin utelnetd || die
	dodoc ChangeLog README

	newinitd "${FILESDIR}"/utelnetd.initd utelnetd
}
