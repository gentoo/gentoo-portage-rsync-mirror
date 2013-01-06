# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xboard/xboard-4.6.2.ebuild,v 1.5 2012/07/12 11:31:05 ago Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="GUI for gnuchess and for internet chess servers"
HOMEPAGE="http://www.gnu.org/software/xboard/"
SRC_URI="mirror://gnu/xboard/${P}.tar.gz
	mirror://gentoo/${PN}.png"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE="Xaw3d +default-font zippy"
RESTRICT="test" #124112

RDEPEND="Xaw3d? ( x11-libs/libXaw3d )
	x11-libs/libXpm
	!Xaw3d? ( x11-libs/libXaw )
	x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXmu
	default-font? (
		media-fonts/font-adobe-100dpi[nls]
		media-fonts/font-misc-misc[nls] )"
DEPEND="${RDEPEND}
	x11-proto/xproto"

src_unpack() {
	unpack ${P}.tar.gz
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-gentoo.patch \
		"${FILESDIR}"/${P}-gettext.patch
	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--datadir="${GAMES_DATADIR}"/${PN} \
		--localedir=/usr/share/locale \
		$(use_with Xaw3d) \
		$(use_enable zippy)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS COPYRIGHT ChangeLog NEWS README TODO ics-parsing.txt
	use zippy && dodoc zippy.README
	dohtml FAQ.html
	doicon "${DISTDIR}"/xboard.png
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "No chess engines are emerged by default! If you want a chess engine"
	elog "to play with, you can emerge gnuchess or crafty."
	elog "Read xboard FAQ for information."
	if ! use default-font ; then
		ewarn "Read the xboard(6) man page for specifying the font for xboard to use."
	fi
}
