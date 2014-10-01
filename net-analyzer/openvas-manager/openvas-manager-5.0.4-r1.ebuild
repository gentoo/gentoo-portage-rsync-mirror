# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-manager/openvas-manager-5.0.4-r1.ebuild,v 1.1 2014/10/01 10:58:58 jlec Exp $

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
	"${FILESDIR}"/${P}-run.patch
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
