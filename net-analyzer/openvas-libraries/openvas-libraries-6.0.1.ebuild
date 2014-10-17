# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-libraries/openvas-libraries-6.0.1.ebuild,v 1.2 2014/10/17 09:12:09 jlec Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="A remote security scanner for Linux (openvas-libraries)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/1417/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.12
	=net-libs/gnutls-2*
	net-libs/libpcap
	app-crypt/gpgme
	!net-analyzer/openvas-libnasl"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig
	dev-util/cmake"

DOCS="ChangeLog CHANGES README"

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
