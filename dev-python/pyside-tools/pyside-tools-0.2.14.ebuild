# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyside-tools/pyside-tools-0.2.14.ebuild,v 1.5 2012/10/19 06:37:46 patrick Exp $

EAPI=4

CMAKE_IN_SOURCE_BUILD="1"

PYTHON_DEPEND="2:2.6 3:3.2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.1 3.3 *-jython 2.7-pypy-*"
PYTHON_TESTS_RESTRICTED_ABIS="3.*"

VIRTUALX_COMMAND="cmake-utils_src_test"

inherit eutils cmake-utils python virtualx

DESCRIPTION="PySide development tools (lupdate, rcc, uic)"
HOMEPAGE="http://www.pyside.org/"
SRC_URI="http://www.pyside.org/files/${P}.tar.bz2"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND="
	>=dev-python/pyside-1.1.0-r1[X]
	>=dev-python/shiboken-1.1.0-r1
	>=x11-libs/qt-core-4.7.0:4
	>=x11-libs/qt-gui-4.7.0:4
"
DEPEND="${RDEPEND}
	test? ( virtual/pkgconfig )
"

src_prepare() {
	epatch "${FILESDIR}"/0.2.13-fix-pysideuic-test-and-install.patch

	python_copy_sources

	preparation() {
		if [[ $(python_get_version -l --major) == 3 ]]; then
			rm -fr pysideuic/port_v2
		else
			rm -fr pysideuic/port_v3
		fi

		sed -i -e "/pkg-config/ s:shiboken:&-python${PYTHON_ABI}:" \
			tests/rcc/run_test.sh || die
	}
	python_execute_function -s preparation
}

src_configure() {
	configuration() {
		local mycmakeargs=(
			-DPYTHON_BASENAME="-python${PYTHON_ABI}"
			-DPYTHON_SUFFIX="-python${PYTHON_ABI}"
			-DSITE_PACKAGE="$(python_get_sitedir)"
			$(cmake-utils_use_build test TESTS)
		)
		CMAKE_USE_DIR="${BUILDDIR}" cmake-utils_src_configure
	}
	python_execute_function -s configuration
}

src_compile() {
	compilation() {
		CMAKE_USE_DIR="${BUILDDIR}" cmake-utils_src_make
	}
	python_execute_function -s compilation
}

src_test() {
	testing() {
		CMAKE_USE_DIR="${BUILDDIR}" virtualmake
	}
	python_execute_function -s testing
}

src_install() {
	installation() {
		CMAKE_USE_DIR="${BUILDDIR}" cmake-utils_src_install DESTDIR="${T}/images/${PYTHON_ABI}"
	}
	python_execute_function -s installation
	python_merge_intermediate_installation_images "${T}/images"

	dodoc AUTHORS ChangeLog
}

pkg_postinst() {
	python_mod_optimize pysideuic
}

pkg_postrm() {
	python_mod_cleanup pysideuic
}
