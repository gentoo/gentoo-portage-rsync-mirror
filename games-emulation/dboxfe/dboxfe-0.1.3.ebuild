# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dboxfe/dboxfe-0.1.3.ebuild,v 1.10 2012/03/29 15:50:13 mr_bones_ Exp $

EAPI=2
inherit eutils qt4-r2 games

DESCRIPTION="Creates and manages configuration files for DOSBox"
HOMEPAGE="http://developer.berlios.de/projects/dboxfe/"
SRC_URI="mirror://berlios/dboxfe/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4
	x11-libs/qt-core:4"
RDEPEND="${DEPEND}
	>=games-emulation/dosbox-0.65"

PATCHES=( "${FILESDIR}"/${P}-ldflags.patch )

src_configure() {
	qt4-r2_src_configure
}

src_install() {
	dogamesbin bin/dboxfe || die
	dodoc TODO ChangeLog
	newicon res/default.png ${PN}.png
	make_desktop_entry dboxfe "DosBoxFE"
	prepgamesdirs
}
