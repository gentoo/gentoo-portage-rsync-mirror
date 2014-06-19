# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/greenbone-security-assistant/greenbone-security-assistant-5.0.1.ebuild,v 1.1 2014/06/19 13:38:01 hanno Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="Greenbone Security Assistant for openvas"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/1675/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND=">=net-analyzer/openvas-libraries-7.0.2
	dev-libs/libxslt
	net-libs/libmicrohttpd[messages]"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

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
	doinitd "${FILESDIR}"/gsad
}
