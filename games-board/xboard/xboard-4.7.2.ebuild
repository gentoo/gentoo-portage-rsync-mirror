# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xboard/xboard-4.7.2.ebuild,v 1.3 2013/09/06 19:03:16 hasufell Exp $

EAPI=5
inherit autotools eutils fdo-mime gnome2-utils games

DESCRIPTION="GUI for gnuchess and for internet chess servers"
HOMEPAGE="http://www.gnu.org/software/xboard/"
SRC_URI="mirror://gnu/xboard/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="Xaw3d +default-font gtk nls xpm zippy"
REQUIRED_USE="?? ( Xaw3d gtk ) xpm? ( !gtk )"
RESTRICT="test" #124112

RDEPEND="
	dev-libs/glib:2
	gnome-base/librsvg:2
	virtual/libintl
	x11-libs/cairo[X]
	Xaw3d? ( x11-libs/libXaw3d )
	!Xaw3d? ( !gtk? ( x11-libs/libXaw ) )
	default-font? (
		media-fonts/font-adobe-100dpi[nls?]
		media-fonts/font-misc-misc[nls?]
	)
	!gtk? (
		x11-libs/libX11
		x11-libs/libXt
		x11-libs/libXmu
	)
	gtk? ( x11-libs/gtk+:2 )
	xpm? ( x11-libs/libXpm )"
DEPEND="${RDEPEND}
	x11-proto/xproto
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-paths.patch \
		"${FILESDIR}"/${P}-gettext.patch \
		"${FILESDIR}"/${P}-configure-switches.patch \
		"${FILESDIR}"/${P}-gnuchess-default.patch
	eautoreconf
}

src_configure() {
	egamesconf \
		--datadir=/usr/share \
		$(use_enable nls) \
		$(use_enable xpm) \
		$(use_enable zippy) \
		--disable-update-mimedb \
		$(use_with gtk) \
		$(use_with Xaw3d) \
		$(usex gtk "--without-Xaw" "$(use_with !Xaw3d Xaw)") \
		--with-gamedatadir="${GAMES_DATADIR}"/${PN}
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS COPYRIGHT ChangeLog NEWS README TODO ics-parsing.txt
	use zippy && dodoc zippy.README
	dohtml FAQ.html
	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
	elog "No chess engines are emerged by default! If you want a chess engine"
	elog "to play with, you can emerge gnuchess or crafty."
	elog "Read xboard FAQ for information."
	if ! use default-font ; then
		ewarn "Read the xboard(6) man page for specifying the font for xboard to use."
	fi
}

pkg_postrm() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
