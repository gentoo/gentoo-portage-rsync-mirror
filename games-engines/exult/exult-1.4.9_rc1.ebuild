# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/exult/exult-1.4.9_rc1.ebuild,v 1.3 2014/05/15 16:41:45 ulm Exp $

EAPI=2
inherit multilib eutils games

DESCRIPTION="an Ultima 7 game engine that runs on modern operating systems"
HOMEPAGE="http://exult.sourceforge.net/"
SRC_URI="mirror://sourceforge/exult/${P/_/}.tar.gz
	mirror://sourceforge/exult/U7MusicOGG_1of2.zip
	mirror://sourceforge/exult/U7MusicOGG_2of2.zip
	mirror://sourceforge/exult/jmsfx.zip
	mirror://sourceforge/exult/jmsfxsi.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="timidity zlib"

RDEPEND=">=media-libs/libpng-1.2.43-r2:0
	media-libs/libsdl[sound,video,X]
	timidity? ( >=media-sound/timidity++-2 )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${P/_/}

src_unpack() {
	unpack ${P/_/}.tar.gz
	mkdir music/
	cd music/
	unpack U7MusicOGG_{1,2}of2.zip
	cd "${WORKDIR}"
	mkdir flx/
	cd flx/
	unpack jmsfx{,si}.zip
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-desktop.patch
}

src_configure() {
	egamesconf \
		--x-libraries="/usr/$(get_libdir)" \
		--disable-dependency-tracking \
		--disable-tools \
		--disable-opengl \
		--enable-mods \
		--with-desktopdir=/usr/share/applications \
		--with-icondir=/usr/share/pixmaps \
		$(use_enable timidity timidity-midi) \
		$(use_enable zlib zip-support)
}

src_install() {
	emake DESTDIR="${D}" install || die
	# no need for this directory for just playing the game
	rm -rf "${D}${GAMES_DATADIR}/${PN}/estudio"
	dodoc AUTHORS ChangeLog NEWS FAQ README README.1ST
	insinto "${GAMES_DATADIR}/${PN}/music"
	doins "${WORKDIR}/music/"*ogg || die "doins failed"
	insinto "${GAMES_DATADIR}/${PN}/"
	doins "${WORKDIR}/flx/"*.flx || die "doins failed"
	newdoc "${WORKDIR}/music/readme.txt" music-readme.txt
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "You *must* have the original Ultima7 The Black Gate and/or"
	elog "The Serpent Isle installed."
	elog "See documentation in /usr/share/doc/${PF} for information."
}
