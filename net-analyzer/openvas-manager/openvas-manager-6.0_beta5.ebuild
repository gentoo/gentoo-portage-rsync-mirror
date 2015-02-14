# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-manager/openvas-manager-6.0_beta5.ebuild,v 1.2 2015/02/14 14:28:55 jlec Exp $

EAPI=5

inherit cmake-utils systemd

MY_PN=openvasmd

DL_ID=1874

DESCRIPTION="A remote security scanner for Linux (openvas-manager)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/${DL_ID}/${P/_beta/+beta}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=net-analyzer/openvas-libraries-8_beta5
	>=dev-db/sqlite-3
	!net-analyzer/openvas-administrator"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}"/${P/_beta/+beta}

PATCHES=(
	"${FILESDIR}"/${PN}-5.0.4-gpgerror.patch
	"${FILESDIR}"/${P}-bsdsource.patch
	)

src_prepare() {
	sed \
		-e '/^install.*OPENVAS_CACHE_DIR.*/d' \
		-i CMakeLists.txt || die
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DLOCALSTATEDIR="${EPREFIX}/var"
		-DSYSCONFDIR="${EPREFIX}/etc"
		)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	insinto /etc/openvas/
	doins "${FILESDIR}"/${MY_PN}-daemon.conf
	dosym ../openvas/${MY_PN}-daemon.conf /etc/conf.d/${PN}

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/${MY_PN}.logrotate ${MY_PN}

	newinitd "${FILESDIR}"/${MY_PN}.init ${MY_PN}
	systemd_dounit "${FILESDIR}"/${MY_PN}.service
}
