# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyQt4/PyQt4-4.9.6.ebuild,v 1.1 2012/12/10 11:20:38 pesa Exp $

EAPI=4

PYTHON_DEPEND="*"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython *-pypy-*"

inherit eutils toolchain-funcs qt4-r2 python

# Minimal supported version of Qt.
QT_VER="4.7.2"

DESCRIPTION="Python bindings for the Qt toolkit"
HOMEPAGE="http://www.riverbankcomputing.co.uk/software/pyqt/intro/ http://pypi.python.org/pypi/PyQt"

if [[ ${PV} == *_pre* ]]; then
	MY_P="PyQt-x11-gpl-snapshot-${PV%_pre*}-${REVISION}"
	SRC_URI="http://dev.gentoo.org/~hwoarang/distfiles/${MY_P}.tar.gz"
else
	MY_P="PyQt-x11-gpl-${PV}"
	SRC_URI="mirror://sourceforge/pyqt/${PN}/PyQt-${PV}/${MY_P}.tar.gz"
fi

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="X assistant dbus debug declarative doc examples kde multimedia opengl phonon sql svg webkit xmlpatterns"

REQUIRED_USE="
	assistant? ( X )
	declarative? ( X )
	multimedia? ( X )
	opengl? ( X )
	phonon? ( X )
	sql? ( X )
	svg? ( X )
	webkit? ( X )
"

RDEPEND="
	>=dev-python/sip-4.14.2
	>=x11-libs/qt-core-${QT_VER}:4
	>=x11-libs/qt-script-${QT_VER}:4
	X? (
		>=x11-libs/qt-gui-${QT_VER}:4[dbus?]
		>=x11-libs/qt-test-${QT_VER}:4
	)
	assistant? ( >=x11-libs/qt-assistant-${QT_VER}:4 )
	dbus? (
		>=dev-python/dbus-python-0.80
		>=x11-libs/qt-dbus-${QT_VER}:4
	)
	declarative? ( >=x11-libs/qt-declarative-${QT_VER}:4 )
	multimedia? ( >=x11-libs/qt-multimedia-${QT_VER}:4 )
	opengl? (
		>=x11-libs/qt-opengl-${QT_VER}:4
		|| ( >=x11-libs/qt-opengl-4.8.0:4 <x11-libs/qt-opengl-4.8.0:4[-egl] )
	)
	phonon? (
		!kde? ( || ( >=x11-libs/qt-phonon-${QT_VER}:4 media-libs/phonon ) )
		kde? ( media-libs/phonon )
	)
	sql? ( >=x11-libs/qt-sql-${QT_VER}:4 )
	svg? ( >=x11-libs/qt-svg-${QT_VER}:4 )
	webkit? ( >=x11-libs/qt-webkit-${QT_VER}:4 )
	xmlpatterns? ( >=x11-libs/qt-xmlpatterns-${QT_VER}:4 )
"
DEPEND="${RDEPEND}
	dbus? ( virtual/pkgconfig )
"

S=${WORKDIR}/${MY_P}

PYTHON_VERSIONED_EXECUTABLES=("/usr/bin/pyuic4")

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
		if [[ $(python_get_version -l --major) == 3 ]]; then
			rm -fr pyuic/uic/port_v2
		else
			rm -fr pyuic/uic/port_v3
		fi
	}
	python_execute_function -s preparation
}

pyqt4_use_enable() {
	use $1 && echo "--enable=${2:-$1}"
}

src_configure() {
	configuration() {
		local myconf=(
			"$(PYTHON)" configure.py
			--confirm-license
			--bindir="${EPREFIX}/usr/bin"
			--destdir="${EPREFIX}$(python_get_sitedir)"
			--sipdir="${EPREFIX}/usr/share/sip"
			--assume-shared
			--no-timestamp
			--qsci-api
			$(use debug && echo --debug)
			--enable=QtCore
			--enable=QtNetwork
			--enable=QtScript
			--enable=QtXml
			$(pyqt4_use_enable X QtGui)
			$(pyqt4_use_enable X QtDesigner) $(use X || echo --no-designer-plugin)
			$(pyqt4_use_enable X QtScriptTools)
			$(pyqt4_use_enable X QtTest)
			$(pyqt4_use_enable assistant QtHelp)
			$(pyqt4_use_enable dbus QtDBus)
			$(pyqt4_use_enable declarative QtDeclarative)
			$(pyqt4_use_enable multimedia QtMultimedia)
			$(pyqt4_use_enable opengl QtOpenGL)
			$(pyqt4_use_enable phonon)
			$(pyqt4_use_enable sql QtSql)
			$(pyqt4_use_enable svg QtSvg)
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
			sed -e "/^LFLAGS[[:space:]]*=/s:-Wl,-rpath,${BUILDDIR}/qpy/${mod}::" \
				-i ${mod}/Makefile || die "Failed to fix rpath for ${mod}"
		done

		# Avoid stripping of libpythonplugin.so.
		if use X; then
			pushd designer > /dev/null || return
			eqmake4 python.pro
			popd > /dev/null || return
		fi
	}
	python_execute_function -s configuration
}

src_install() {
	installation() {
		# INSTALL_ROOT is used by designer/Makefile, other Makefiles use DESTDIR.
		emake DESTDIR="${T}/images/${PYTHON_ABI}" INSTALL_ROOT="${T}/images/${PYTHON_ABI}" install
	}
	python_execute_function -s installation
	python_merge_intermediate_installation_images "${T}/images"

	dodoc NEWS THANKS

	if use doc; then
		dohtml -r doc/html/*
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}

pkg_postinst() {
	python_mod_optimize PyQt4

	ewarn "When updating dev-python/PyQt4, you usually need to rebuild packages that depend on it,"
	ewarn "such as dev-python/qscintilla-python and kde-base/pykde4. If you have app-portage/gentoolkit"
	ewarn "installed, you can find these packages with \`equery d dev-python/PyQt4\`."
}

pkg_postrm() {
	python_mod_cleanup PyQt4
}
