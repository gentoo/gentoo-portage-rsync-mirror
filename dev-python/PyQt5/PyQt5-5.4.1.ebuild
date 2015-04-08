# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyQt5/PyQt5-5.4.1.ebuild,v 1.1 2015/03/02 03:19:23 pesa Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit eutils multibuild multilib python-r1 qmake-utils

DESCRIPTION="Python bindings for the Qt framework"
HOMEPAGE="http://www.riverbankcomputing.co.uk/software/pyqt/intro/
	https://pypi.python.org/pypi/PyQt5"

MY_PN="PyQt-gpl"
if [[ ${PV} == *_pre* ]]; then
	MY_P=${MY_PN}-${PV%_pre*}-snapshot-${REVISION}
	SRC_URI="http://dev.gentoo.org/~pesa/distfiles/${MY_P}.tar.xz"
else
	MY_P=${MY_PN}-${PV}
	SRC_URI="mirror://sourceforge/pyqt/${MY_P}.tar.gz"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

# TODO: bluetooth, webchannel, webengine
IUSE="dbus debug declarative designer doc examples gui help multimedia network
	opengl positioning printsupport sensors serialport sql svg testlib webkit
	websockets widgets x11extras xmlpatterns"
REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	positioning? ( gui )
	sensors? ( gui )
	serialport? ( gui )
	sql? ( widgets )
	testlib? ( widgets )
	websockets? ( gui )
"

# Minimal supported version of Qt.
QT_PV="5.3.2:5"

RDEPEND="
	${PYTHON_DEPS}
	>=dev-python/sip-4.16.6:=[${PYTHON_USEDEP}]
	>=dev-qt/qtcore-${QT_PV}
	>=dev-qt/qtxml-${QT_PV}
	dbus? (
		dev-python/dbus-python[${PYTHON_USEDEP}]
		>=dev-qt/qtdbus-${QT_PV}
	)
	declarative? ( >=dev-qt/qtdeclarative-${QT_PV}[widgets?] )
	designer? ( >=dev-qt/designer-${QT_PV} )
	gui? ( >=dev-qt/qtgui-${QT_PV} )
	help? ( >=dev-qt/qthelp-${QT_PV} )
	multimedia? ( >=dev-qt/qtmultimedia-${QT_PV}[widgets?] )
	network? ( >=dev-qt/qtnetwork-${QT_PV} )
	opengl? ( >=dev-qt/qtopengl-${QT_PV} )
	positioning? ( >=dev-qt/qtpositioning-${QT_PV} )
	printsupport? ( >=dev-qt/qtprintsupport-${QT_PV} )
	sensors? ( >=dev-qt/qtsensors-${QT_PV} )
	serialport? ( >=dev-qt/qtserialport-${QT_PV} )
	sql? ( >=dev-qt/qtsql-${QT_PV} )
	svg? ( >=dev-qt/qtsvg-${QT_PV} )
	testlib? ( >=dev-qt/qttest-${QT_PV} )
	webkit? ( >=dev-qt/qtwebkit-${QT_PV}[printsupport] )
	websockets? ( >=dev-qt/qtwebsockets-${QT_PV} )
	widgets? ( >=dev-qt/qtwidgets-${QT_PV} )
	x11extras? ( >=dev-qt/qtx11extras-${QT_PV} )
	xmlpatterns? ( >=dev-qt/qtxmlpatterns-${QT_PV} )
"
DEPEND="${RDEPEND}
	dbus? ( virtual/pkgconfig )
"

S=${WORKDIR}/${MY_P}

src_prepare() {
	# Avoid automagic dependency.
	use dbus || rm -fr dbus
}

pyqt_use_enable() {
	use $1 && echo --enable=${2:-Qt$(tr 'a-z' 'A-Z' <<< ${1:0:1})${1:1}}
}

src_configure() {
	configuration() {
		local myconf=(
			"${PYTHON}"
			"${S}"/configure.py
			--confirm-license
			--qmake="${EPREFIX}/usr/$(get_libdir)/qt5/bin/qmake"
			--destdir="$(python_get_sitedir)"
			--assume-shared
			--no-timestamp
			--qsci-api
			$(use debug && echo --debug)
			--enable=QtCore
			--enable=QtXml
			$(pyqt_use_enable dbus QtDBus)
			$(pyqt_use_enable declarative QtQml)
			$(pyqt_use_enable declarative QtQuick)
			$(usex declarative '' '' $(pyqt_use_enable widgets QtQuickWidgets))
			$(usex declarative '' --no-qml-plugin)
			$(pyqt_use_enable designer)
			$(usex designer '' --no-designer-plugin)
			$(pyqt_use_enable gui)
			$(pyqt_use_enable help)
			$(pyqt_use_enable multimedia)
			$(usex multimedia '' '' $(pyqt_use_enable widgets QtMultimediaWidgets))
			$(pyqt_use_enable network)
			$(pyqt_use_enable opengl QtOpenGL)
			$(pyqt_use_enable positioning)
			$(pyqt_use_enable printsupport QtPrintSupport)
			$(pyqt_use_enable sensors)
			$(pyqt_use_enable serialport QtSerialPort)
			$(pyqt_use_enable sql)
			$(pyqt_use_enable svg)
			$(pyqt_use_enable testlib QtTest)
			$(pyqt_use_enable webkit QtWebKit)
			$(pyqt_use_enable webkit QtWebKitWidgets)
			$(pyqt_use_enable websockets QtWebSockets)
			$(pyqt_use_enable widgets)
			$(pyqt_use_enable x11extras QtX11Extras)
			$(pyqt_use_enable xmlpatterns QtXmlPatterns)
		)
		echo "${myconf[@]}"
		"${myconf[@]}" || die

		eqmake5 -recursive ${PN}.pro
	}
	python_foreach_impl run_in_build_dir configuration
}

src_compile() {
	python_foreach_impl run_in_build_dir default
}

src_install() {
	installation() {
		local tmp_root=${D%/}/tmp
		emake INSTALL_ROOT="${tmp_root}" install

		local uic_dir=${tmp_root}$(python_get_sitedir)/${PN}/uic
		if python_is_python3; then
			rm -r "${uic_dir}"/port_v2 || die
		else
			rm -r "${uic_dir}"/port_v3 || die
		fi

		python_doexe "${tmp_root}${EPREFIX}"/usr/bin/pyuic5
		rm "${tmp_root}${EPREFIX}"/usr/bin/pyuic5 || die

		multibuild_merge_root "${tmp_root}" "${D}"
		python_optimize
	}
	python_foreach_impl run_in_build_dir installation

	dodoc ChangeLog NEWS

	if use doc; then
		dodoc -r doc/html
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
