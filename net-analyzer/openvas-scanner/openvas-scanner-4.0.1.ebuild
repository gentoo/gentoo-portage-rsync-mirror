# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-scanner/openvas-scanner-4.0.1.ebuild,v 1.1 2014/06/19 13:36:02 hanno Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="A remote security scanner for Linux (openvas-scanner)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/1640/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE=""

RDEPEND=">=net-analyzer/openvas-libraries-7.0.2
	!net-analyzer/openvas-plugins
	!net-analyzer/openvas-server"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/cmake"

src_configure() {
	local mycmakeargs="-DLOCALSTATEDIR=/var -DSYSCONFDIR=/etc"
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc ChangeLog CHANGES README || die "dodoc failed"
	doinitd "${FILESDIR}"/openvassd || die
}

pkg_postinst() {
	elog "To use openvassd, you first need to:"
	elog "1. Call 'openvas-nvt-sync' to download/update plugins"
	elog "2. Call 'openvas-mkcert' to generate a server certificate"
	elog "3. Call 'openvas-adduser' to create a user"
}
