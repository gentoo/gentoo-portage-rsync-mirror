# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/yaml-cpp/yaml-cpp-0.3.0.ebuild,v 1.3 2013/08/07 10:37:12 pinkbyte Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="A YAML parser and emitter in C++"
HOMEPAGE="http://code.google.com/p/yaml-cpp/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i \
		-e 's:INCLUDE_INSTALL_ROOT_DIR:INCLUDE_INSTALL_DIR:g' \
		yaml-cpp.pc.cmake || die

}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
	)
	cmake-utils_src_configure
}
