# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/awale/awale-1.5.ebuild,v 1.2 2013/01/27 19:27:19 hasufell Exp $

EAPI=5
inherit autotools eutils gnome2-utils games

DESCRIPTION="Free Awale - The game of all Africa"
HOMEPAGE="http://www.nongnu.org/awale/"
SRC_URI="mirror://nongnu/awale/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="tk"

RDEPEND="tk? ( dev-lang/tcl dev-lang/tk )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
	mv configure.in configure.ac || die
	mv src/xawale.tcl src/xawale.tcl.in || die
	eautoreconf
}

src_configure() {
	egamesconf \
		--mandir=/usr/share/man \
		--with-iconsdir=/usr/share/icons/hicolor/48x48/apps \
		--with-desktopdir=/usr/share/applications \
		$(use_enable tk)
}

src_install() {
	emake -j1 DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README THANKS
	prepgamesdirs
	use tk && fperms +x "${GAMES_DATADIR}"/${PN}/xawale.tcl
}

pkg_preinst() {
	games_pkg_preinst
	use tk && gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst
	use tk && gnome2_icon_cache_update
}

pkg_postrm() {
	use tk && gnome2_icon_cache_update
}
