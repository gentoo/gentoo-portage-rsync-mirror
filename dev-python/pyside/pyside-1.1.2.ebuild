# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyside/pyside-1.1.2.ebuild,v 1.7 2013/03/02 20:57:50 hwoarang Exp $

EAPI=4

PYTHON_DEPEND="2:2.6 3:3.2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.1 3.3 *-jython 2.7-pypy-*"

VIRTUALX_COMMAND="cmake-utils_src_test"

inherit multilib cmake-utils python virtualx

MY_P="${PN}-qt4.8+${PV}"

DESCRIPTION="Python bindings for the Qt framework"
HOMEPAGE="http://www.pyside.org/"
SRC_URI="http://www.pyside.org/files/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~arm x86 ~amd64-linux ~x86-linux"
IUSE="X declarative help kde multimedia opengl phonon script scripttools sql svg test webkit xmlpatterns"

REQUIRED_USE="
	declarative? ( X )
	help? ( X )
	multimedia? ( X )
	opengl? ( X )
	phonon? ( X )
	scripttools? ( X script )
	sql? ( X )
	svg? ( X )
	test? ( X )
	webkit? ( X )
"

# Minimal supported version of Qt.
QT_PV="4.7.0:4"

RDEPEND="
	>=dev-python/shiboken-${PV}
	>=dev-qt/qtcore-${QT_PV}
	X? (
		>=dev-qt/qtgui-${QT_PV}[accessibility]
		>=dev-qt/qttest-${QT_PV}
	)
	declarative? ( >=dev-qt/qtdeclarative-${QT_PV} )
	help? ( >=dev-qt/qthelp-${QT_PV} )
	multimedia? ( >=dev-qt/qtmultimedia-${QT_PV} )
	opengl? ( >=dev-qt/qtopengl-${QT_PV} )
	phonon? (
		kde? ( media-libs/phonon )
		!kde? ( || ( >=dev-qt/qtphonon-${QT_PV} media-libs/phonon ) )
	)
	script? ( >=dev-qt/qtscript-${QT_PV} )
	sql? ( >=dev-qt/qtsql-${QT_PV} )
	svg? ( >=dev-qt/qtsvg-${QT_PV}[accessibility] )
	webkit? ( >=dev-qt/qtwebkit-${QT_PV} )
	xmlpatterns? ( >=dev-qt/qtxmlpatterns-${QT_PV} )
"
DEPEND="${RDEPEND}
	>=dev-qt/qtgui-${QT_PV}
"

S=${WORKDIR}/${MY_P}

DOCS=( ChangeLog )

src_prepare() {
	# Fix generated pkgconfig file to require the shiboken
	# library suffixed with the correct python version.
	sed -i -e '/^Requires:/ s/shiboken$/&@SHIBOKEN_PYTHON_SUFFIX@/' \
		libpyside/pyside.pc.in || die

	if use prefix; then
		cp "${FILESDIR}"/rpath.cmake .
		sed \
			-i '1iinclude(rpath.cmake)' \
			CMakeLists.txt || die
	fi
}

src_configure() {
	configuration() {
		local mycmakeargs=(
			-DPYTHON_SUFFIX="-python${PYTHON_ABI}"
			$(cmake-utils_use_build test TESTS)
			$(cmake-utils_use_disable X QtGui)
			$(cmake-utils_use_disable X QtDesigner)
			$(cmake-utils_use_disable X QtTest)
			$(cmake-utils_use_disable X QtUiTools)
			$(cmake-utils_use_disable declarative QtDeclarative)
			$(cmake-utils_use_disable help QtHelp)
			$(cmake-utils_use_disable multimedia QtMultimedia)
			$(cmake-utils_use_disable opengl QtOpenGL)
			$(cmake-utils_use_disable phonon)
			$(cmake-utils_use_disable script QtScript)
			$(cmake-utils_use_disable scripttools QtScriptTools)
			$(cmake-utils_use_disable sql QtSql)
			$(cmake-utils_use_disable svg QtSvg)
			$(cmake-utils_use_disable webkit QtWebKit)
			$(cmake-utils_use_disable xmlpatterns QtXmlPatterns)
		)
		CMAKE_BUILD_DIR="${S}_${PYTHON_ABI}" cmake-utils_src_configure
	}
	python_execute_function configuration
}

src_compile() {
	compilation() {
		CMAKE_BUILD_DIR="${S}_${PYTHON_ABI}" cmake-utils_src_make
	}
	python_execute_function compilation
}

src_test() {
	testing() {
		CMAKE_BUILD_DIR="${S}_${PYTHON_ABI}" virtualmake
	}
	python_enable_pyc
	python_execute_function testing
	python_disable_pyc
}

src_install() {
	installation() {
		CMAKE_BUILD_DIR="${S}_${PYTHON_ABI}" cmake-utils_src_install
		mv "${ED}"usr/$(get_libdir)/pkgconfig/${PN}{,-python${PYTHON_ABI}}.pc || die
	}
	python_execute_function installation
}
