# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qtsingleapplication/qtsingleapplication-2.6.1_p20130904-r1.ebuild,v 1.2 2014/07/11 21:18:53 zlogene Exp $

EAPI=5

inherit qt4-r2

MY_P=qt-solutions-${PV#*_p}

DESCRIPTION="Qt library to start applications only once per user"
HOMEPAGE="http://doc.qt.digia.com/solutions/4/qtsingleapplication/index.html"
SRC_URI="http://dev.gentoo.org/~pesa/distfiles/${MY_P}.tar.xz"

LICENSE="|| ( LGPL-2.1 GPL-3 )"
SLOT="0"
KEYWORDS="amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE="X doc"

DEPEND="
	dev-qt/qtcore:4
	dev-qt/qtlockedfile
	X? ( dev-qt/qtgui:4 )
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}/${PN}

PATCHES=(
	"${FILESDIR}/${PV}-unbundle-qtlockedfile.patch"
	"${FILESDIR}/${PV}-no-gui.patch"
)

src_prepare() {
	qt4-r2_src_prepare

	echo 'SOLUTIONS_LIBRARY = yes' > config.pri
	use X || echo 'QTSA_NO_GUI = yes' >> config.pri

	sed -i -e "s/-head/-${PV%.*}/" common.pri || die
	sed -i -e '/SUBDIRS+=examples/d' ${PN}.pro || die

	# to ensure unbundling
	rm -f src/qtlockedfile*
}

src_install() {
	dodoc README.TXT

	dolib.so lib/*
	insinto /usr/include/qt4/QtSolutions/
	doins src/qtsinglecoreapplication.h
	use X && doins src/{QtSingleApplication,${PN}.h}

	insinto /usr/share/qt4/mkspecs/features/
	doins "${FILESDIR}"/${PN}.prf
	dosym ${PN}.prf /usr/share/qt4/mkspecs/features/qtsinglecoreapplication.prf

	use doc && dohtml -r doc/html
}
