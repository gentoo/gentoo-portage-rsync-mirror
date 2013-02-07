# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnubg/gnubg-20130203.ebuild,v 1.1 2013/02/07 17:45:32 hasufell Exp $

EAPI=5
PYTHON_COMPAT=( python2_5 python2_6 python2_7 )
inherit autotools eutils python-single-r1 gnome2-utils games

DESCRIPTION="GNU BackGammon"
HOMEPAGE="http://www.gnubg.org/"
SRC_URI="http://www.gnubg.org/media/sources/${PN}-source-SNAPSHOT-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="gtk opengl python threads"

GTK_DEPS="
	x11-libs/gtk+:2
	x11-libs/cairo
	x11-libs/pango"
RDEPEND="dev-libs/glib:2
	media-libs/libpng:0
	dev-libs/libxml2
	media-libs/freetype:2
	media-libs/libcanberra
	gtk? ( ${GTK_DEPS} )
	opengl? (
		${GTK_DEPS}
		x11-libs/gtkglext
		>=media-libs/ftgl-2.1.2-r1
	)
	sys-libs/readline
	python? ( ${PYTHON_DEPS} )
	media-fonts/ttf-bitstream-vera
	virtual/libintl
	dev-db/sqlite:3"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext"

S=${WORKDIR}/${PN}

pkg_setup() {
	games_pkg_setup
	python-single-r1_pkg_setup
}

src_prepare() {
	# use ${T} instead of /tmp for constructing credits (bug #298275)
	sed -i -e 's:/tmp:${T}:' credits.sh || die
	epatch "${FILESDIR}"/${P}-build.patch
	eautoreconf
	sed -i \
		-e 's#^localedir =.*$#localedir = @localedir@#' \
		-e 's#^gnulocaledir =.*$#gnulocaledir = @localedir@#' \
		po/Makefile.in.in || die
}

src_configure() {
	egamesconf \
		--localedir=/usr/share/locale \
		--docdir=/usr/share/doc/${PF}/html \
		$(use_enable threads) \
		$(use_with python) \
		$(use gtk || use opengl && echo --with-gtk) \
		$(use_with opengl board3d)
}

src_install() {
	default
	insinto "${GAMES_DATADIR}/${PN}"
	doins ${PN}.weights *bd
	rm -rf "${D}${GAMES_DATADIR}/${PN}/fonts"
	dosym /usr/share/fonts/ttf-bitstream-vera "${GAMES_DATADIR}"/${PN}/fonts
	newicon -s 128 textures/logo.png gnubg.png
	make_desktop_entry "gnubg -w" "GNU Backgammon"
	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
