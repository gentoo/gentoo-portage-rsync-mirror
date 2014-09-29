# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-manager/openvas-manager-6.0_beta2.ebuild,v 1.1 2014/09/29 19:37:47 jlec Exp $

EAPI=5

inherit cmake-utils systemd

MY_PN=openvasmd

DESCRIPTION="A remote security scanner for Linux (openvas-manager)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/1746/${P/_beta/+beta}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=net-analyzer/openvas-libraries-8.0.0
	>=dev-db/sqlite-3
	!net-analyzer/openvas-administrator"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/cmake"

S="${WORKDIR}"/${P/_beta/+beta}

PATCHES=(
	"${FILESDIR}"/${PN}-5.0.4-gpgerror.patch
	"${FILESDIR}"/${PN}-5.0.4-bsdsource.patch
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
