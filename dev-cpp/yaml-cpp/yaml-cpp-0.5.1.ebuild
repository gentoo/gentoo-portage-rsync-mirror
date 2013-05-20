# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/yaml-cpp/yaml-cpp-0.5.1.ebuild,v 1.1 2013/05/20 02:09:05 neurogeek Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="A YAML parser and emitter in C++"
HOMEPAGE="http://code.google.com/p/yaml-cpp/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i \
		-e 's:INCLUDE_INSTALL_ROOT_DIR:INCLUDE_INSTALL_DIR:g' \
		yaml-cpp.pc.cmake || die

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
	)
	cmake-utils_src_configure
}
