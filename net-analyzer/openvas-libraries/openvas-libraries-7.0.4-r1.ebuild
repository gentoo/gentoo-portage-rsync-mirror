# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-libraries/openvas-libraries-7.0.4-r1.ebuild,v 1.1 2014/09/30 16:00:26 jlec Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="A remote security scanner for Linux (openvas-libraries)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/1722/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="ldap"

RDEPEND="
	>=dev-libs/glib-2.12
	net-libs/gnutls
	net-libs/libpcap
	app-crypt/gpgme
	!net-analyzer/openvas-libnasl
	net-libs/libssh
	ldap? (	net-nds/openldap )"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig
	dev-util/cmake"

DOCS="ChangeLog CHANGES README"

PATCHES=(
	"${FILESDIR}"/${P}-libssh.patch
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
		"-DLOCALSTATEDIR=${EPREFIX}/var"
		"-DSYSCONFDIR=${EPREFIX}/etc"
		$(cmake-utils_use_build ldap WITH_LDAP)
	)
	cmake-utils_src_configure
}
