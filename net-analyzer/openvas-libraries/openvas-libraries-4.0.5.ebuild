# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-libraries/openvas-libraries-4.0.5.ebuild,v 1.3 2012/05/04 06:08:09 jdhore Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="A remote security scanner for Linux (openvas-libraries)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/872/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.12
	net-libs/gnutls
	net-libs/libpcap
	app-crypt/gpgme
	!net-analyzer/openvas-libnasl"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig
	dev-util/cmake"

DOCS="ChangeLog CHANGES README"

CMAKE_IN_SOURCE_BUILD=1

src_prepare() {
	sed \
		-e 's:-Werror::g' \
		-i CMakeLists.txt \
		-i */CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		"-DLOCALSTATEDIR=${EPREFIX}/var"
		"-DSYSCONFDIR=${EPREFIX}/etc"
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	keepdir /var/cache/openvas/
}
