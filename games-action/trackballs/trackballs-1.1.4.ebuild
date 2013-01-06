# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/trackballs/trackballs-1.1.4.ebuild,v 1.10 2012/06/05 15:42:35 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="simple game similar to the classical game Marble Madness"
HOMEPAGE="http://trackballs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://sourceforge/${PN}/${PN}-music-1.4.tar.bz2"

LICENSE="GPL-2 FML-1"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="nls"

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl[audio,joystick,video]
	>=dev-scheme/guile-1.8:12[deprecated]
	media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/sdl-ttf
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_prepare() {
	sed -i \
		-e 's/icons //' share/Makefile.in \
		|| die "sed failed"
	sed -i \
		-e '/^localedir/s:=.*:=/usr/share/locale:' \
		src/Makefile.in \
		po/Makefile.in.in \
		|| die "sed failed"
	# Fix _FORTIFY_SOURCE buffer overflow due to wrong sizeof
	sed -i \
		-e 's/\(snprintf(\(name\),sizeof\)(str)/\1(\2)/' \
		src/enterHighScoreMode.cc || die
	# Fix -Wformat-security warning due to non-literal with no format arguments
	sed -i \
		-e 's/\(snprintf(levelname,sizeof(levelname),\)\(name)\)/\1 "%s", \2/' \
		-e 's/\(snprintf(Settings::settings->specialLevel,sizeof(Settings::settings->specialLevel),\)\(levelname)\)/\1 "%s", \2/' \
		src/editMode.cc || die
	sed -i \
		-e 's/\(snprintf(\(textureName\),\)63\(,textureNames\[i\])\)/\1 sizeof(\2), "%s"\3/' \
		src/map.cc || die
	epatch "${FILESDIR}"/${P}-warning.patch
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--with-highscores="${GAMES_STATEDIR}"/${PN}-highscores \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	insinto "${GAMES_DATADIR}"/${PN}/music
	doins "${WORKDIR}"/trackballs-music/*.ogg || die "doins failed"
	newicon share/icons/${PN}-64x64.png ${PN}.png
	make_desktop_entry ${PN} Trackballs
	dodoc AUTHORS ChangeLog FAQ NEWS README TODO
	prepgamesdirs
}
