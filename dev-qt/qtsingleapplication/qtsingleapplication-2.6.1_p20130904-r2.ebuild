# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qtsingleapplication/qtsingleapplication-2.6.1_p20130904-r2.ebuild,v 1.1 2015/01/02 18:17:33 kensington Exp $

EAPI=5

inherit multibuild multilib qmake-utils

MY_P=qt-solutions-${PV#*_p}

DESCRIPTION="Qt library to start applications only once per user"
HOMEPAGE="http://doc.qt.digia.com/solutions/4/qtsingleapplication/index.html"
SRC_URI="http://dev.gentoo.org/~pesa/distfiles/${MY_P}.tar.xz"

LICENSE="|| ( LGPL-2.1 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE="doc +qt4 qt5 X"

REQUIRED_USE="|| ( qt4 qt5 )"

DEPEND="
	qt4? ( 
		dev-qt/qtcore:4
		X? ( dev-qt/qtgui:4 )
	)
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtnetwork:5
		X? (
			dev-qt/qtgui:5
			dev-qt/qtwidgets:5
		)
	)
	dev-qt/qtlockedfile[qt4?,qt5?]
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}/${PN}

pkg_setup() {
	MULTIBUILD_VARIANTS=()
	if use qt4 ; then
		MULTIBUILD_VARIANTS+=( qt4 )
	fi
	if use qt5 ; then
		MULTIBUILD_VARIANTS+=( qt5 )
	fi
}

src_prepare() {
	epatch "${FILESDIR}/${PV}-unbundle-qtlockedfile.patch"
	epatch "${FILESDIR}/${PV}-no-gui.patch"

	echo 'SOLUTIONS_LIBRARY = yes' > config.pri
	use X || echo 'QTSA_NO_GUI = yes' >> config.pri

	sed -i -e "s/-head/-${PV%.*}/" common.pri || die
	sed -i -e '/SUBDIRS+=examples/d' ${PN}.pro || die

	# to ensure unbundling
	rm -f src/qtlockedfile*

	multibuild_copy_sources
}

src_configure() {
	myconfigure() {
		if [[ ${MULTIBUILD_VARIANT} = qt4 ]] ; then
			eqmake4
		fi
		if [[ ${MULTIBUILD_VARIANT} = qt5 ]] ; then
			eqmake5
		fi
	}

	multibuild_foreach_variant run_in_build_dir myconfigure
}

src_compile() {
	multibuild_foreach_variant run_in_build_dir default
}

src_install() {
	dodoc README.TXT
	use doc && dodoc -r doc/html

	myinstall() {
		if [[ ${MULTIBUILD_VARIANT} = qt4 ]] ; then
			insinto /usr/include/qt4/QtSolutions/
			doins src/qtsinglecoreapplication.h
			use X && doins src/{QtSingleApplication,${PN}.h}

			insinto /usr/share/qt4/mkspecs/features/
			doins "${FILESDIR}"/${PN}.prf
			dosym ${PN}.prf /usr/share/qt4/mkspecs/features/qtsinglecoreapplication.prf
		fi

		if [[ ${MULTIBUILD_VARIANT} = qt5 ]] ; then
			insinto /usr/include/qt5/QtSolutions/
			doins src/qtsinglecoreapplication.h
			use X && doins src/{QtSingleApplication,${PN}.h}

			insinto /usr/$(get_libdir)/qt5/mkspecs/features/
			newins "${FILESDIR}"/${PN}5.prf ${PN}.prf
			dosym ${PN}.prf /usr/$(get_libdir)/qt5/mkspecs/features/qtsinglecoreapplication.prf
		fi

		dolib.so lib/*
	}

	multibuild_foreach_variant run_in_build_dir myinstall
}
