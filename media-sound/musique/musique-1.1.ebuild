# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/musique/musique-1.1.ebuild,v 1.3 2012/07/12 18:59:41 hwoarang Exp $

EAPI="4"

inherit eutils qt4-r2

DESCRIPTION="Qt4 music player."
HOMEPAGE="http://flavio.tordini.org/musique"
# Same tarball for every release. We repackage it
SRC_URI="http://dev.gentoo.org/~hwoarang/distfiles/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	x11-libs/qt-gui:4[dbus]
	x11-libs/qt-sql:4[sqlite]
	|| ( x11-libs/qt-phonon:4 media-libs/phonon )
	media-libs/taglib
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

DOCS="CHANGES TODO"

src_prepare () {
	# bug 422665
	epatch "${FILESDIR}"/${P}-gcc47.patch
	qt4-r2_src_prepare
}

src_configure() {
	eqmake4 ${PN}.pro PREFIX="/usr"
}

src_install() {
	qt4-r2_src_install
	doicon data/${PN}.svg
}
