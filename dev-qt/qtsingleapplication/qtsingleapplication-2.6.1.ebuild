# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qtsingleapplication/qtsingleapplication-2.6.1.ebuild,v 1.1 2013/09/04 14:52:13 kensington Exp $

EAPI=5

inherit qt4-r2 versionator

MY_P="${PN}-$(replace_version_separator 2 _)-opensource"

DESCRIPTION="Qt library to start applications only once per user"
HOMEPAGE="http://doc.qt.digia.com/solutions/4/qtsingleapplication/index.html"
SRC_URI="http://dev.gentoo.org/~kensington/distfiles/${MY_P}.tar.gz"

LICENSE="|| ( LGPL-2.1 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND="dev-qt/qtcore:4
	dev-qt/qtgui:4"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

PATCHES=(
	"${FILESDIR}/${P}-examples.patch"
	"${FILESDIR}/${P}-gcc47.patch"
	"${FILESDIR}/${P}-unbundle.patch"
)

src_prepare() {
	qt4-r2_src_prepare

	# to ensure unbundling
	rm src/qtlockedfile*
}

src_configure() {
	eqmake4 CONFIG+=qtsingleapplication-uselib
}

src_install() {
	dolib.so lib/*
	insinto /usr/include/qt4/QtSolutions/
	doins src/QtSingleApplication src/${PN}.h

	insinto /usr/share/qt4/mkspecs/features/
	doins "${FILESDIR}/${PN}.prf"

	if use doc ; then
		dodoc -r examples
		dodoc doc/index.qdoc
		dohtml -r doc/html/ doc/images
	fi
}
