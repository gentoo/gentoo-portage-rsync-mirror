# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyQt4/PyQt4-4.9.6-r2.ebuild,v 1.3 2013/02/13 08:52:33 pesa Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7,3_1,3_2,3_3} )

inherit eutils qt4-r2 python-r1 toolchain-funcs

DESCRIPTION="Python bindings for the Qt toolkit"
HOMEPAGE="http://www.riverbankcomputing.co.uk/software/pyqt/intro/ http://pypi.python.org/pypi/PyQt"

if [[ ${PV} == *_pre* ]]; then
	MY_P="PyQt-x11-gpl-snapshot-${PV%_pre*}-${REVISION}"
	SRC_URI="http://dev.gentoo.org/~hwoarang/distfiles/${MY_P}.tar.gz"
else
	MY_P="PyQt-x11-gpl-${PV}"
	SRC_URI="mirror://sourceforge/pyqt/${MY_P}.tar.gz"
fi

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"

IUSE="X dbus debug declarative doc examples help kde multimedia opengl phonon script scripttools sql svg webkit xmlpatterns"
REQUIRED_USE="
	declarative? ( X )
	help? ( X )
	multimedia? ( X )
	opengl? ( X )
	phonon? ( X )
	scripttools? ( X script )
	sql? ( X )
	svg? ( X )
	webkit? ( X )
"

# Minimal supported version of Qt.
QT_PV="4.8.0:4"

RDEPEND="
	${PYTHON_DEPS}
	>=dev-python/sip-4.14.2:=[${PYTHON_USEDEP}]
	>=x11-libs/qt-core-${QT_PV}
	X? (
		>=x11-libs/qt-gui-${QT_PV}[dbus?]
		>=x11-libs/qt-test-${QT_PV}
	)
	dbus? (
		>=dev-python/dbus-python-0.80
		>=x11-libs/qt-dbus-${QT_PV}
	)
	declarative? ( >=x11-libs/qt-declarative-${QT_PV} )
	help? ( >=x11-libs/qt-assistant-${QT_PV} )
	multimedia? ( >=x11-libs/qt-multimedia-${QT_PV} )
	opengl? ( >=x11-libs/qt-opengl-${QT_PV} )
	phonon? (
		kde? ( media-libs/phonon )
		!kde? ( || ( >=x11-libs/qt-phonon-${QT_PV} media-libs/phonon ) )
	)
	script? ( >=x11-libs/qt-script-${QT_PV} )
	sql? ( >=x11-libs/qt-sql-${QT_PV} )
	svg? ( >=x11-libs/qt-svg-${QT_PV} )
	webkit? ( >=x11-libs/qt-webkit-${QT_PV} )
	xmlpatterns? ( >=x11-libs/qt-xmlpatterns-${QT_PV} )
"
DEPEND="${RDEPEND}
	dbus? ( virtual/pkgconfig )
"

S=${WORKDIR}/${MY_P}

src_prepare() {
	qt4-r2_src_prepare

	# Support qreal on arm architecture (bug 322349).
	use arm && epatch "${FILESDIR}/${PN}-4.7.3-qreal_float_support.patch"

	# Use proper include directory for phonon.
	sed -i -e "s:^\s\+generate_code(\"phonon\":&, extra_include_dirs=[\"${EPREFIX}/usr/include/phonon\"]:" \
		configure.py || die

	if ! use dbus; then
		sed -i -e 's/^\(\s\+\)check_dbus()/\1pass/' configure.py || die
	fi

	python_copy_sources

	preparation() {
		if [[ ${EPYTHON} == python3.* ]]; then
			rm -fr pyuic/uic/port_v2
		else
			rm -fr pyuic/uic/port_v3
		fi
	}
	python_foreach_impl run_in_build_dir preparation
}

pyqt4_use_enable() {
	use $1 && echo --enable=${2:-Qt$(tr 'a-z' 'A-Z' <<< ${1:0:1})${1:1}}
}

src_configure() {
	configuration() {
		local myconf=(
			"${PYTHON}" configure.py
			--confirm-license
			--bindir="${EPREFIX}/usr/bin"
			--destdir="$(python_get_sitedir)"
			--sipdir="${EPREFIX}/usr/share/sip"
			--assume-shared
			--no-timestamp
			--qsci-api
			$(use debug && echo --debug)
			--enable=QtCore
			--enable=QtNetwork
			--enable=QtXml
			$(pyqt4_use_enable X QtDesigner) $(use X || echo --no-designer-plugin)
			$(pyqt4_use_enable X QtGui)
			$(pyqt4_use_enable X QtTest)
			$(pyqt4_use_enable dbus QtDBus)
			$(pyqt4_use_enable declarative)
			$(pyqt4_use_enable help)
			$(pyqt4_use_enable multimedia)
			$(pyqt4_use_enable opengl QtOpenGL)
			$(pyqt4_use_enable phonon phonon)
			$(pyqt4_use_enable script)
			$(pyqt4_use_enable scripttools QtScriptTools)
			$(pyqt4_use_enable sql)
			$(pyqt4_use_enable svg)
			$(pyqt4_use_enable webkit QtWebKit)
			$(pyqt4_use_enable xmlpatterns QtXmlPatterns)
			AR="$(tc-getAR) cqs"
			CC="$(tc-getCC)"
			CFLAGS="${CFLAGS}"
			CFLAGS_RELEASE=
			CXX="$(tc-getCXX)"
			CXXFLAGS="${CXXFLAGS}"
			CXXFLAGS_RELEASE=
			LINK="$(tc-getCXX)"
			LINK_SHLIB="$(tc-getCXX)"
			LFLAGS="${LDFLAGS}"
			LFLAGS_RELEASE=
			RANLIB=
			STRIP=
		)
		echo "${myconf[@]}"
		"${myconf[@]}" || die

		local mod
		for mod in QtCore \
				$(use X && echo QtDesigner QtGui) \
				$(use dbus && echo QtDBus) \
				$(use declarative && echo QtDeclarative) \
				$(use opengl && echo QtOpenGL); do
			# Run eqmake4 inside the qpy subdirectories to respect
			# CC, CXX, CFLAGS, CXXFLAGS, LDFLAGS and avoid stripping.
			pushd qpy/${mod} > /dev/null || return
			eqmake4 $(ls w_qpy*.pro)
			popd > /dev/null || return

			# Fix insecure runpaths.
			sed -i -e "/^LFLAGS\s*=/ s:-Wl,-rpath,${BUILDDIR}/qpy/${mod}::" \
				${mod}/Makefile || die "Failed to fix rpath for ${mod}"
		done

		# Avoid stripping of libpythonplugin.so.
		if use X; then
			pushd designer > /dev/null || return
			eqmake4 python.pro
			popd > /dev/null || return
		fi
	}
	python_foreach_impl run_in_build_dir configuration
}

src_compile() {
	python_foreach_impl run_in_build_dir default
}

src_install() {
	installation() {
		# INSTALL_ROOT is used by designer/Makefile, other Makefiles use DESTDIR.
		emake DESTDIR="${D}" INSTALL_ROOT="${D}" install
		mv "${ED}"/usr/bin/pyuic4{,-${EPYTHON}} || die
		python_optimize
	}
	python_foreach_impl run_in_build_dir installation

	dosym python-exec /usr/bin/pyuic4
	dodoc NEWS THANKS

	if use doc; then
		dohtml -r doc/html/*
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
