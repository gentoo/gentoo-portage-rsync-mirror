# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libplist/libplist-1.10.ebuild,v 1.2 2013/11/23 21:48:38 pacho Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )
inherit cmake-utils python-r1

DESCRIPTION="Support library to deal with Apple Property Lists (Binary & XML)"
HOMEPAGE="http://www.libimobiledevice.org/"
SRC_URI="http://www.libimobiledevice.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-fbsd"
IUSE="python"

RDEPEND="dev-libs/libxml2"
DEPEND="${RDEPEND}
	python? (
		${PYTHON_DEPS}
		>=dev-python/cython-0.14.1-r1[${PYTHON_USEDEP}]
		)"

DOCS=( AUTHORS NEWS README )

MAKEOPTS+=" -j1" #406365

src_configure() {
	use python && python_export_best

	# Use cython instead of swig to match behavior of libimobiledevice >= 1.1.2
	local mycmakeargs=(
		-DCMAKE_SKIP_RPATH=ON
		$(cmake-utils_use_enable python CYTHON)
		-DENABLE_SWIG=OFF
	)

	cmake-utils_src_configure
}

src_test() {
	cd "${CMAKE_BUILD_DIR}"

	local testfile
	for testfile in "${S}"/test/data/*; do
		LD_LIBRARY_PATH=src ./test/plist_test "${testfile}" || die
	done
}
