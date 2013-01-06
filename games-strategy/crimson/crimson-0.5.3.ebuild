# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/crimson/crimson-0.5.3.ebuild,v 1.4 2009/11/13 17:16:29 volkmar Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Tactical war game in the tradition of Battle Isle"
HOMEPAGE="http://crimson.seul.org/"
SRC_URI="http://crimson.seul.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="test zlib"

RDEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	media-libs/sdl-net
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	test? (
		=app-text/docbook-xml-dtd-4.2*
		dev-libs/libxml2
	)"

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--enable-sound \
		--enable-network \
		$(use_with zlib) \
		--enable-cfed \
		--enable-bi2cf \
		--enable-comet \
		--enable-cf2bmp
}

src_install() {
	emake \
		DESTDIR="${D}" \
		pixmapsdir="/usr/share/pixmaps" \
		install || die "emake install failed"
	dodoc NEWS README* THANKS TODO
	rm -rf "${D}/${GAMES_DATADIR}/applications"
	make_desktop_entry crimson "Crimson Fields"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	ewarn "Crimson Fields ${PV} is not necessarily save-game compatible with previous versions."
	echo
	elog "If you have older save files and you wish to continue those games,"
	elog "you'll need to remerge the version with which you started"
	elog "those save-games."
}
