# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-manager/openvas-manager-2.0.4.ebuild,v 1.2 2012/05/04 06:08:10 jdhore Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="A remote security scanner for Linux (openvas-manager)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/871/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=net-analyzer/openvas-libraries-4
	>=dev-db/sqlite-3"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/cmake"

src_configure() {
	local mycmakeargs="-DLOCALSTATEDIR=/var -DSYSCONFDIR=/etc"
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc ChangeLog CHANGES README TODO || die "dodoc failed"
	doinitd "${FILESDIR}"/openvasmd || die
}

pkg_postinst() {
	elog "To allow openvasmd to work, you need to"
	elog "1. create a client certificate with openvas-mkcert-client -n om -i"
	elog "2. create an openvasmd database with openvasmd --rebuild"
}
