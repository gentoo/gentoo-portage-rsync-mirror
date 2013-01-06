# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/exult/exult-1.2.ebuild,v 1.23 2011/09/15 02:44:46 ssuominen Exp $

EAPI=2
inherit eutils autotools multilib games

DESCRIPTION="an Ultima 7 game engine that runs on modern operating systems"
HOMEPAGE="http://exult.sourceforge.net/"
SRC_URI="mirror://sourceforge/exult/${P}.tar.gz
	mirror://sourceforge/exult/U7MusicOGG_1of2.zip
	mirror://sourceforge/exult/U7MusicOGG_2of2.zip
	mirror://sourceforge/exult/jmsfx.zip
	mirror://sourceforge/exult/jmsfxsi.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE="timidity zlib"

RDEPEND=">=media-libs/libpng-1.4
	media-libs/libsdl[audio,video,X]
	media-libs/sdl-mixer[vorbis,timidity?]
	timidity? ( >=media-sound/timidity++-2 )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	app-arch/unzip"

# upstream says... "the opengl renderer is very very experimental and
# not recommended for actual use"
#opengl? ( virtual/opengl )

src_unpack() {
	unpack ${P}.tar.gz
	mkdir music/
	cd music/
	unpack U7MusicOGG_{1,2}of2.zip
	cd "${WORKDIR}"
	mkdir flx/
	cd flx/
	unpack jmsfx{,si}.zip
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-gcc41.patch \
		"${FILESDIR}"/${P}-64bits.patch \
		"${FILESDIR}"/${P}-x11link.patch \
		"${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-gcc44.patch \
		"${FILESDIR}"/${P}-libpng14.patch \
		"${FILESDIR}"/${P}-libpng15.patch
	sed -i \
		-e "s/u7siinstrics.data/u7siintrinsics.data/" \
		usecode/ucxt/data/Makefile.am \
		|| die "sed usecode/ucxt/data/Makefile.am failed"
	sed -i \
		-e '/^Encoding/d' \
		-e '/^Icon/s/\.png//' \
		-e '/^Categories/s/Application;//' \
		desktop/exult.desktop \
		|| die
	# This fix is needed for gimp-plugin support if we want to turn that on.
	#sed -i \
		#-e 's/$(DESTDIR)$(GIMP_PLUGINS) /$(GIMP_PLUGINS) $(DESTDIR)/' \
		#mapedit/Makefile.in \
		#|| die "sed mapedit/Makefile.in failed"
	eautoreconf
}

src_configure() {
	egamesconf \
		--x-libraries="/usr/$(get_libdir)" \
		--disable-dependency-tracking \
		--disable-tools \
		--disable-opengl \
		$(use_enable timidity) \
		$(use_enable zlib zip-support)
}

src_install() {
	emake \
		DESTDIR="${D}" \
		desktopdir=/usr/share/applications/ \
		icondir=/usr/share/icons \
		install || die "emake install failed"
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
	elog "See README in /usr/share/doc/${PF} for information."
}
