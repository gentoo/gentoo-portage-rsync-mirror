# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-administrator/openvas-administrator-1.1.1.ebuild,v 1.2 2012/05/04 06:08:09 jdhore Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="A remote security scanner for Linux (openvas-administrator)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/853/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=net-analyzer/openvas-libraries-4"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/cmake"

# Workaround for upstream bug, it doesn't like out-of-tree builds.
CMAKE_BUILD_DIR="${S}"

src_configure() {
	local mycmakeargs="-DLOCALSTATEDIR=/var -DSYSCONFDIR=/etc"
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc ChangeLog CHANGES README || die "dodoc failed"
	doinitd "${FILESDIR}"/openvasad
}

pkg_postinst() {
	elog "You need to create an admin user for openvasad to work:"
	elog "openvasad -c 'add_user' -n [username] -r Admin"
}
