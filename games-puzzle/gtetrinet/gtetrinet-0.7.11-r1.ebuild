# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gtetrinet/gtetrinet-0.7.11-r1.ebuild,v 1.9 2012/11/30 20:05:06 hasufell Exp $

EAPI=2
# games after gnome2 so games' functions will override gnome2's
inherit autotools eutils gnome2 games

DESCRIPTION="Tetrinet Clone for GNOME 2"
HOMEPAGE="http://gtetrinet.sourceforge.net/"
SRC_URI="${SRC_URI}
	mirror://gentoo/gtetrinet-gentoo-theme-0.1.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="nls ipv6"

RDEPEND="dev-libs/libxml2
	media-libs/libcanberra
	>=gnome-base/gconf-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-{noesd,desktopfile}.patch
	sed -i \
		-e "/^pkgdatadir =/s:=.*:= ${GAMES_DATADIR}/${PN}:" \
		src/Makefile.in themes/*/Makefile.in || die
	sed -i \
		-e '/^gamesdir/s:=.*:=@bindir@:' \
		src/Makefile.am || die
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable ipv6) \
		--bindir="${GAMES_BINDIR}" \
		|| die
}

src_install() {
	USE_DESTDIR=1 gnome2_src_install
	dodoc AUTHORS ChangeLog NEWS README TODO
	mv "${WORKDIR}"/gentoo "${D}/${GAMES_DATADIR}"/${PN}/themes/
	prepgamesdirs
}

pkg_preinst() {
	gnome2_pkg_preinst
	games_pkg_preinst
}

pkg_postinst() {
	gnome2_pkg_postinst
	games_pkg_postinst
}
