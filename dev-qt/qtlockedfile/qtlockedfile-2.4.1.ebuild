# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qtlockedfile/qtlockedfile-2.4.1.ebuild,v 1.1 2013/09/04 14:34:43 kensington Exp $

EAPI=5

inherit eutils multilib qt4-r2 versionator

MY_P="${PN}-$(replace_version_separator 2 _)-opensource"

DESCRIPTION="QFile extension with advisory locking functions"
HOMEPAGE="http://doc.qt.digia.com/solutions/4/qtlockedfile/index.html"
SRC_URI="http://dev.gentoo.org/~kensington/distfiles/${MY_P}.tar.gz"

LICENSE="|| ( LGPL-2.1 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND="dev-qt/qtcore:4"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

PATCHES=(
	"${FILESDIR}/${P}-depend.patch"
	"${FILESDIR}/${P}-examples.patch"
)

src_configure() {
	eqmake4 CONFIG+=qtlockedfile-uselib
}

src_install() {
	dodoc README.TXT

	dolib.so lib/*
	insinto /usr/include/qt4/QtSolutions/
	doins src/QtLockedFile src/${PN}.h

	insinto /usr/share/qt4/mkspecs/features/
	doins "${FILESDIR}/${PN}.prf"

	if use doc ; then
		dodoc -r example
		dodoc doc/index.qdoc
		dohtml -r doc/html/ doc/images
	fi
}
