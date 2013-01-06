# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/acetoneiso/acetoneiso-2.3.ebuild,v 1.2 2012/07/24 22:08:20 pesa Exp $

EAPI=4
MY_P=${PN}_${PV}

inherit flag-o-matic qt4-r2

DESCRIPTION="a feature-rich and complete software application to manage CD/DVD images"
HOMEPAGE="http://www.acetoneteam.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="kde"

DEPEND="x11-libs/qt-core:4
	x11-libs/qt-dbus:4
	x11-libs/qt-gui:4
	x11-libs/qt-webkit:4
	kde? ( media-libs/phonon )
	!kde? ( || ( x11-libs/qt-phonon:4 media-libs/phonon ) )"
RDEPEND="${DEPEND}
	sys-fs/fuseiso"

S=${WORKDIR}/${MY_P}/${PN}
DOCS=(../AUTHORS ../CHANGELOG ../FEATURES ../README)

src_prepare() {
	sed -i -e 's:unrar-nonfree:unrar:g' sources/compress.h locale/*.ts || die
	sed -i -e 's:include <Phonon/:include <:' sources/* || die "phonon sed failed"
}

src_configure() {
	append-cxxflags -I/usr/include/KDE/Phonon

	qt4-r2_src_configure
}
