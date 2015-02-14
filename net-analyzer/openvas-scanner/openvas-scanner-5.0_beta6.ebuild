# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-scanner/openvas-scanner-5.0_beta6.ebuild,v 1.2 2015/02/14 18:55:15 jlec Exp $

EAPI=5

inherit cmake-utils systemd

MY_PN=openvassd

DL_ID=1926

DESCRIPTION="A remote security scanner for Linux (OpenVAS-scanner)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/${DL_ID}/${P/_beta/+beta}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS=""
IUSE="postgres sqlite"

REQUIRED_USE="^^ ( postgres sqlite )"

RDEPEND="
	app-crypt/gpgme
	>=dev-libs/glib-2.16:2
	dev-libs/libgcrypt:0
	>=net-analyzer/openvas-libraries-8_beta6
	!net-analyzer/openvas-plugins
	!net-analyzer/openvas-server
	postgres? ( dev-db/postgresql )
	sqlite? ( dev-db/sqlite:3 )
	"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}"/${P/_beta/+beta}

PATCHES=(
	"${FILESDIR}"/${PN}-4.0.3-mkcertclient.patch
	"${FILESDIR}"/${PN}-4.0.3-rulesdir.patch
	"${FILESDIR}"/${PN}-4.0.3-run.patch
	)

src_prepare() {
	sed \
		-e '/^install.*OPENVAS_CACHE_DIR.*/d' \
		-i CMakeLists.txt || die
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		"-DLOCALSTATEDIR=${EPREFIX}/var"
		"-DSYSCONFDIR=${EPREFIX}/etc"
		$(usex postgres "-DBACKEND=POSTGRESQL" "-DBACKEND=SQLITE3")
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	newinitd "${FILESDIR}"/${MY_PN}.init ${MY_PN}

	insinto /etc/openvas
	doins "${FILESDIR}"/${MY_PN}.conf "${FILESDIR}"/${MY_PN}-daemon.conf
	dosym ../openvas/${MY_PN}-daemon.conf /etc/conf.d/${PN}

	insinto /etc/logrotate.d
	doins "${FILESDIR}"/${MY_PN}.logrotate

	dodoc "${FILESDIR}"/openvas-nvt-sync-cron

	systemd_newtmpfilesd "${FILESDIR}"/${MY_PN}.tmpfiles.d ${MY_PN}.conf
	systemd_dounit "${FILESDIR}"/${MY_PN}.service
}
