# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/lgeneral/lgeneral-1.2.3.ebuild,v 1.6 2014/10/20 07:00:23 tupone Exp $

EAPI=5
inherit eutils autotools games

MY_P="${P/_/}"
MY_P="${MY_P/beta/beta-}"
DESCRIPTION="A Panzer General clone written in SDL"
HOMEPAGE="http://lgames.sourceforge.net/index.php?project=LGeneral"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz
	mirror://sourceforge/${PN}/pg-data.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls"

RDEPEND="media-libs/libsdl[sound,video]
	media-libs/sdl-mixer
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	sys-devel/gettext"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-format.patch
	sed -i \
		-e '/desktop_DATA/d' \
		-e '/icon_DATA/d' \
		Makefile.am || die

	cp /usr/share/gettext/config.rpath .
	rm -f missing
	eautoreconf

	# Build a temporary lgc-pg that knows about ${WORKDIR}:
	cp -pPR "${S}" "${WORKDIR}"/tmp-build || die "cp failed"
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}:" \
		-e "s:@D@::" \
		{lgc-pg,src}/misc.c \
		|| die "sed failed"

	cd "${WORKDIR}"/tmp-build
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}:" \
		-e "s:@D@:${D}:" \
		{lgc-pg,src}/misc.c \
		|| die "sed failed (tmp)"
}

src_configure() {
	egamesconf \
		$(use_enable nls)

	# Build the temporary lgc-pg:
	cd "${WORKDIR}"/tmp-build
	egamesconf \
		--disable-nls \
		--datadir="${D}/${GAMES_DATADIR}"
}

src_compile() {
	emake

	# Build the temporary lgc-pg:
	cd "${WORKDIR}"/tmp-build
	emake
}

src_install() {
	default
	keepdir "${GAMES_DATADIR}"/${PN}/{ai_modules,music,terrain}

	# Generate scenario data:
	dodir "${GAMES_DATADIR}"/${PN}/gfx/{flags,units,terrain} #413901
	SDL_VIDEODRIVER=dummy "${WORKDIR}"/tmp-build/lgc-pg/lgc-pg \
		-s "${WORKDIR}"/pg-data \
		-d "${D}/${GAMES_DATADIR}"/${PN} \
		|| die "Failed to generate scenario data"

	newicon lgeneral48.png ${PN}.png
	make_desktop_entry ${PN} LGeneral
	prepgamesdirs
}
