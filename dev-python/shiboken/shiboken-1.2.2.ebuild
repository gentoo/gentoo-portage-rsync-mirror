# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/shiboken/shiboken-1.2.2.ebuild,v 1.2 2014/06/20 15:03:52 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} )

inherit multilib cmake-utils python-r1

DESCRIPTION="A tool for creating Python bindings for C++ libraries"
HOMEPAGE="http://qt-project.org/wiki/PySide"
SRC_URI="http://download.qt-project.org/official_releases/pyside/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="
	>=dev-libs/libxml2-2.6.32
	>=dev-libs/libxslt-1.1.19
	>=dev-qt/qtcore-4.7.0:4
	>=dev-qt/qtxmlpatterns-4.7.0:4
	!dev-python/apiextractor
	!dev-python/generatorrunner
"
DEPEND="${RDEPEND}
	test? (
		>=dev-qt/qtgui-4.7.0:4
		>=dev-qt/qttest-4.7.0:4
	)"

DOCS=( AUTHORS ChangeLog )

src_prepare() {
	# Fix inconsistent naming of libshiboken.so and ShibokenConfig.cmake,
	# caused by the usage of a different version suffix with python >= 3.2
	sed -i -e "/get_config_var('SOABI')/d" \
		cmake/Modules/FindPython3InterpWithDebug.cmake || die

	if use prefix; then
		cp "${FILESDIR}"/rpath.cmake . || die
		sed -i -e '1iinclude(rpath.cmake)' CMakeLists.txt || die
	fi
}

src_configure() {
	configuration() {
		local mycmakeargs=(
			$(cmake-utils_use_build test TESTS)
			-DPYTHON_EXECUTABLE="${PYTHON}"
			-DPYTHON_SITE_PACKAGES="$(python_get_sitedir)"
			-DPYTHON_SUFFIX="-${EPYTHON}"
		)

		if [[ ${EPYTHON} == python3* ]]; then
			mycmakeargs+=(
				-DUSE_PYTHON3=ON
				-DPYTHON3_EXECUTABLE="${PYTHON}"
				-DPYTHON3_INCLUDE_DIR="$(python_get_includedir)"
				-DPYTHON3_LIBRARY="$(python_get_library_path)"
			)
		fi

		cmake-utils_src_configure
	}
	python_foreach_impl configuration
}

src_compile() {
	python_foreach_impl cmake-utils_src_make
}

src_test() {
	python_foreach_impl cmake-utils_src_test
}

src_install() {
	installation() {
		cmake-utils_src_install
		mv "${ED}"usr/$(get_libdir)/pkgconfig/${PN}{,-${EPYTHON}}.pc || die
	}
	python_foreach_impl installation
}
