# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnubg/gnubg-1.04.000.ebuild,v 1.1 2014/11/14 09:00:27 mr_bones_ Exp $

EAPI=5
PYTHON_COMPAT=( python2_6 python2_7 )
inherit autotools eutils python-single-r1 gnome2-utils games

DESCRIPTION="GNU BackGammon"
HOMEPAGE="http://www.gnubg.org/"
SRC_URI="http://gnubg.org/media/sources/${PN}-release-${PV}-sources.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="avx gtk opengl python sqlite3 sse sse2 threads"

RDEPEND="dev-libs/glib:2
	media-libs/freetype:2
	media-libs/libpng:0
	x11-libs/cairo
	x11-libs/pango
	dev-db/sqlite:3
	media-libs/libcanberra
	dev-libs/libxml2
	dev-libs/gmp:0
	gtk? ( x11-libs/gtk+:2 )
	opengl? (
		x11-libs/gtk+:2
		x11-libs/gtkglext
		virtual/glu
	)
	sys-libs/readline
	python? ( ${PYTHON_DEPS} )
	media-fonts/ttf-bitstream-vera
	virtual/libintl"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	games_pkg_setup
	python-single-r1_pkg_setup
}

src_prepare() {
	# use ${T} instead of /tmp for constructing credits (bug #298275)
	sed -i -e 's:/tmp:${T}:' credits.sh || die
	sed -i \
		-e '/^localedir / s#=.*$#= @localedir@#' \
		-e '/^gnulocaledir / s#=.*$#= @localedir@#' \
		po/Makefile.in.in || die
	sed -i \
		-e '/^gnubgiconsdir / s#=.*#= /usr/share#' \
		-e '/^gnubgpixmapsdir / s#=.*#= /usr/share/pixmaps#' \
		pixmaps/Makefile.in || die
}

src_configure() {
	local simd=no
	local gtk_arg=--without-gtk

	if use gtk || use opengl ; then
		gtk_arg=--with-gtk
	fi
	use sse  && simd=sse
	use sse2 && simd=sse2
	use avx  && simd=avx
	egamesconf \
		--localedir=/usr/share/locale \
		--docdir=/usr/share/doc/${PF}/html \
		--disable-cputest \
		--enable-simd=${simd} \
		${gtk_arg} \
		$(use_enable threads) \
		$(use_with python) \
		$(use_with sqlite3 sqlite) \
		$(use_with opengl board3d)
}

src_install() {
	default
	insinto "${GAMES_DATADIR}/${PN}"
	doins ${PN}.weights *bd
	rm -rf "${D}${GAMES_DATADIR}/${PN}/fonts"
	dosym /usr/share/fonts/ttf-bitstream-vera "${GAMES_DATADIR}"/${PN}/fonts
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
