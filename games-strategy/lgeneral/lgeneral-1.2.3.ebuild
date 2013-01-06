# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/lgeneral/lgeneral-1.2.3.ebuild,v 1.4 2012/09/03 10:05:13 phajdan.jr Exp $

EAPI=2
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

RDEPEND="media-libs/libsdl[audio,video]
	media-libs/sdl-mixer
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	sys-devel/gettext"

S=${WORKDIR}/${MY_P}

src_prepare() {
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
		--disable-dependency-tracking \
		$(use_enable nls) \
		|| die

	# Build the temporary lgc-pg:
	cd "${WORKDIR}"/tmp-build
	egamesconf \
		--disable-dependency-tracking \
		--disable-nls \
		--datadir="${D}/${GAMES_DATADIR}" \
		|| die
}

src_compile() {
	emake || die "emake failed"

	# Build the temporary lgc-pg:
	cd "${WORKDIR}"/tmp-build
	emake || die "emake failed (tmp)"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	keepdir "${GAMES_DATADIR}"/${PN}/{ai_modules,music,terrain}

	# Generate scenario data:
	dodir "${GAMES_DATADIR}"/${PN}/gfx/{flags,units,terrain} #413901
	SDL_VIDEODRIVER=dummy "${WORKDIR}"/tmp-build/lgc-pg/lgc-pg \
		-s "${WORKDIR}"/pg-data \
		-d "${D}/${GAMES_DATADIR}"/${PN} \
		|| die "Failed to generate scenario data"

	dodoc AUTHORS ChangeLog README.lgeneral README.lgc-pg TODO
	newicon lgeneral48.png ${PN}.png
	make_desktop_entry ${PN} LGeneral
	prepgamesdirs
}
