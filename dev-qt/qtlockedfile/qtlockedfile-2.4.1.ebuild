# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qtlockedfile/qtlockedfile-2.4.1.ebuild,v 1.3 2013/10/10 10:19:53 pinkbyte Exp $

EAPI=5

inherit eutils multilib qt4-r2 versionator

MY_P="${PN}-$(replace_version_separator 2 _)-opensource"

DESCRIPTION="QFile extension with advisory locking functions"
HOMEPAGE="http://doc.qt.digia.com/solutions/4/qtlockedfile/index.html"
SRC_URI="http://dev.gentoo.org/~kensington/distfiles/${MY_P}.tar.gz"

LICENSE="|| ( LGPL-2.1 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
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
