# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qtlockedfile/qtlockedfile-2.4.1_p20130904-r1.ebuild,v 1.5 2015/03/02 09:04:19 ago Exp $

EAPI=5

inherit multibuild multilib qmake-utils

MY_P=qt-solutions-${PV#*_p}

DESCRIPTION="QFile extension with advisory locking functions"
HOMEPAGE="http://doc.qt.digia.com/solutions/4/qtlockedfile/index.html"
SRC_URI="http://dev.gentoo.org/~pesa/distfiles/${MY_P}.tar.xz"

LICENSE="|| ( LGPL-2.1 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc +qt4 qt5"

REQUIRED_USE="|| ( qt4 qt5 )"

DEPEND="
	qt4? ( dev-qt/qtcore:4 )
	qt5? ( dev-qt/qtcore:5 )
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}/${PN}

pkg_setup() {
	MULTIBUILD_VARIANTS=( $(usev qt4) $(usev qt5) )
}

src_prepare() {
	echo 'SOLUTIONS_LIBRARY = yes' > config.pri
	echo 'QT -= gui' >> src/qtlockedfile.pri

	sed -i -e "s/-head/-${PV%.*}/" common.pri || die
	sed -i -e '/SUBDIRS+=example/d' ${PN}.pro || die

	multibuild_copy_sources
}

src_configure() {
	myconfigure() {
		if [[ ${MULTIBUILD_VARIANT} == qt4 ]]; then
			eqmake4
		fi
		if [[ ${MULTIBUILD_VARIANT} == qt5 ]]; then
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
		if [[ ${MULTIBUILD_VARIANT} == qt4 ]]; then
			insinto /usr/include/qt4/QtSolutions
			doins src/QtLockedFile src/${PN}.h

			insinto /usr/share/qt4/mkspecs/features
			doins "${FILESDIR}"/${PN}.prf
		fi

		if [[ ${MULTIBUILD_VARIANT} == qt5 ]]; then
			insinto /usr/include/qt5/QtSolutions
			doins src/QtLockedFile src/${PN}.h

			insinto /usr/$(get_libdir)/qt5/mkspecs/features
			newins "${FILESDIR}"/${PN}5.prf ${PN}.prf
		fi

		dolib.so lib/*
	}

	multibuild_foreach_variant run_in_build_dir myinstall
}
