# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/osqoop/osqoop-1.1.1.ebuild,v 1.2 2012/07/26 15:15:03 kensington Exp $

EAPI=4

inherit cmake-utils toolchain-funcs

DESCRIPTION="multi-platform open source software oscilloscope based on Qt 4"
HOMEPAGE="http://gitorious.org/osqoop/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/qt-gui:4
	virtual/libusb:0"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}-${PN}

src_prepare() {
	for f in $(find datasource processing -name CMakeLists.txt); do
		sed -e '/install(TARGETS/s:DESTINATION :DESTINATION '$(get_libdir)/${PN}'/:' \
			-i "${f}" || die
	done
	sed -e '/install(TARGETS/s:DESTINATION .:DESTINATION bin:' \
		-i src/CMakeLists.txt helper/CMakeLists.txt || die

	sed -e '/potentialDirs/s:/usr/share/osqoop/:'${EPREFIX}'/usr/'$(get_libdir)/${PN}'/:' \
		-i src/OscilloscopeWindow.cpp || die
}
