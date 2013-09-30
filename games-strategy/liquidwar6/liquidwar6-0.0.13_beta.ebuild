# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/liquidwar6/liquidwar6-0.0.13_beta.ebuild,v 1.2 2013/09/30 12:17:37 hasufell Exp $

EAPI=5

inherit autotools eutils toolchain-funcs games

MY_PV=${PV/_beta/beta}
MY_P=${PN}-${MY_PV}

DESCRIPTION="Unique multiplayer wargame between liquids"
HOMEPAGE="http://www.gnu.org/software/liquidwar6/"
SRC_URI="http://www.ufoot.org/download/liquidwar/v6/${MY_PV}/${MY_P}.tar.gz
	maps? ( http://www.ufoot.org/download/liquidwar/v6/${MY_PV}/${PN}-extra-maps-${MY_PV}.tar.gz )"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc gtk +maps nls +ogg openmp readline"

RDEPEND="dev-db/sqlite:3
	dev-libs/expat
	dev-scheme/guile
	media-libs/freetype:2
	media-libs/libpng:0
	media-libs/libsdl[X,opengl,video]
	media-libs/sdl-image[jpeg,png]
	media-libs/sdl-ttf
	net-misc/curl
	sys-libs/zlib
	virtual/glu
	virtual/jpeg
	virtual/opengl
	gtk? ( x11-libs/gtk+:2 )
	nls? ( virtual/libintl
		virtual/libiconv )
	ogg? (
		media-libs/libsdl[X,audio,opengl,video]
		media-libs/sdl-mixer[vorbis]
	)
	readline? ( sys-libs/ncurses
		sys-libs/readline )"
DEPEND="${RDEPEND}
	dev-lang/perl
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${MY_P}
S_MAPS=${WORKDIR}/${PN}-extra-maps-${MY_PV}

pkg_setup() {
	if use openmp; then
		if [[ $(tc-getCC) == *gcc ]] && ! tc-has-openmp ; then
			ewarn "OpenMP is not available in your current selected gcc"
			die "need openmp capable gcc"
		fi
	fi
	games_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-libpng-1.6.patch \
		"${FILESDIR}"/${P}-ldconfig.patch \
		"${FILESDIR}"/${P}-paths.patch
	eautoreconf
}

src_configure() {
	egamesconf \
		$(use_enable nls) \
		--enable-mod-gl \
		$(use_enable gtk) \
		$(use_enable openmp) \
		$(use_enable ogg mod-ogg) \
		$(use_enable !ogg silent) \
		$(use_enable readline console) \
		--disable-static \
		--mandir=/usr/share/man \
		--docdir=/usr/share/doc/${PF} \
		--htmldir=/usr/share/doc/${PF}/html \
		--with-iconsdir=/usr/share/pixmaps \
		--with-desktopdir=/usr/share/applications

	if use maps; then
		cd "${S_MAPS}" || die
		egamesconf
	fi
}

src_compile() {
	default
	use doc && emake html
	use maps && emake -C "${S_MAPS}"
}

src_install() {
	emake DESTDIR="${D}" install
	use maps && emake -C "${S_MAPS}" DESTDIR="${D}" install
	prune_libtool_files --all
	prepgamesdirs
}
