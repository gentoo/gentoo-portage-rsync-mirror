# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-manager/openvas-manager-5.0.4.ebuild,v 1.1 2014/09/28 18:23:17 jlec Exp $

EAPI=5

inherit cmake-utils systemd

MY_PN=openvasmd

DESCRIPTION="A remote security scanner for Linux (openvas-manager)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/1730/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE=""

RDEPEND="
	>=net-analyzer/openvas-libraries-7.0.4
	>=dev-db/sqlite-3
	!net-analyzer/openvas-administrator"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/cmake"

PATCHES=(
	"${FILESDIR}"/${P}-gpgerror.patch
	"${FILESDIR}"/${P}-bsdsource.patch
	)

src_configure() {
	local mycmakeargs="-DLOCALSTATEDIR=/var -DSYSCONFDIR=/etc"
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc ChangeLog CHANGES README TODO

	insinto /etc/openvas/
	doins "${FILESDIR}"/${MY_PN}-daemon.conf
	newconfd "${FILESDIR}"/${MY_PN}-daemon.conf ${MY_PN}

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/${MY_PN}.logrotate ${MY_PN}

	newinitd "${FILESDIR}"/${MY_PN}.init ${MY_PN}
	systemd_dounit "${FILESDIR}"/${MY_PN}.service
}

pkg_postinst() {
	elog "To allow ${MY_PN} to work, you need to"
	elog "1. create a client certificate with openvas-mkcert-client -n om -i"
	elog "2. create an ${MY_PN} database with ${MY_PN} --rebuild"
}
