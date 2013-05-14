# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/awale/awale-1.5.ebuild,v 1.4 2013/05/14 19:10:11 hasufell Exp $

# do not use autotools related stuff in stable ebuilds
# unless you like random breakage: 469796, 469798, 424041

EAPI=5
inherit eutils gnome2-utils games # STABLE ARCH
# inherit autotools eutils gnome2-utils games # UNSTABLE ARCH

DESCRIPTION="Free Awale - The game of all Africa"
HOMEPAGE="http://www.nongnu.org/awale/"
SRC_URI="mirror://nongnu/awale/${P}.tar.gz"
SRC_URI="${SRC_URI} http://dev.gentoo.org/~hasufell/distfiles/${P}-no-autoreconf.patch.xz" # STABLE ARCH

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="tk"

RDEPEND="tk? ( dev-lang/tcl dev-lang/tk )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
	epatch "${DISTDIR}"/${P}-no-autoreconf.patch.xz # STABLE ARCH

	mv src/xawale.tcl src/xawale.tcl.in || die
#	mv configure.in configure.ac || die # UNSTABLE ARCH
#	eautoreconf # UNSTABLE ARCH
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
