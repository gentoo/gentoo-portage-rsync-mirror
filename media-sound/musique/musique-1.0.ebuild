# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/musique/musique-1.0.ebuild,v 1.2 2012/01/21 11:01:34 hwoarang Exp $

EAPI="4"

inherit qt4-r2

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

DOCS="CHANGES TODO"

src_configure() {
	eqmake4 ${PN}.pro PREFIX="/usr"
}
