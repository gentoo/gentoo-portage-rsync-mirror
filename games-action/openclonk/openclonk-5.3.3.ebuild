# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/openclonk/openclonk-5.3.3.ebuild,v 1.5 2013/09/05 19:44:52 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python2_6 python2_7 )
inherit autotools eutils flag-o-matic gnome2-utils python-any-r1 toolchain-funcs games

MY_P=${PN}-release-${PV}-src

DESCRIPTION="A free multiplayer action game where you control clonks"
HOMEPAGE="http://openclonk.org/"
SRC_URI="http://dev.gentoo.org/~hasufell/distfiles/${P}.tar.xz
	http://${PN}.org/homepage/icon.png -> ${PN}.png"

LICENSE="BSD ISC CLONK-trademark LGPL-2.1 POSTGRESQL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="dedicated doc mp3 sound upnp"

RDEPEND="
	media-libs/libpng:0
	sys-libs/zlib
	virtual/jpeg
	!dedicated? (
		media-libs/freetype:2
		media-libs/glew
		media-libs/libsdl[X,opengl,video]
		virtual/opengl
		virtual/glu
		x11-libs/cairo
		x11-libs/gdk-pixbuf
		x11-libs/gtk+:3
		x11-libs/libXrandr
		x11-libs/libX11
		sound? (
			media-libs/libsdl[audio]
			media-libs/sdl-mixer[mp3?,vorbis,wav]
		)
	)
	dedicated? ( sys-libs/readline:0 )
	upnp? ( net-libs/libupnp )"
DEPEND="${RDEPEND}
	>=dev-libs/boost-1.40
	virtual/pkgconfig
	doc? (
		${PYTHON_DEPS}
		dev-libs/libxml2[python]
		sys-devel/gettext
		)"

pkg_setup() {
	games_pkg_setup
	use doc && python-any-r1_pkg_setup
}

src_prepare() {
	# remove license files
	sed \
		-e '/dist_doc_DATA/s#planet/COPYING ##' \
		-e '/dist_doc_DATA/s#licenses/LGPL.txt ##' \
		-i Makefile.am || die

	eautoreconf
}

src_configure() {
	egamesconf \
		--docdir=/usr/share/doc/${PF} \
		$(use_enable dedicated console) \
		$(use_enable sound) \
		$(use_enable mp3) \
		$(usex dedicated "--with-gtk=no" "--with-gtk=3.0") \
		$(use_with upnp) \
		--without-openal \
		--disable-autoupdate
}

src_compile() {
	emake AR=$(tc-getAR)

	if use doc ; then
		emake -C docs
	fi
}

src_install() {
	emake DESTDIR="${D}" install

	if ! use dedicated; then
		newgamesbin "${FILESDIR}"/${PN}-wrapper-script.sh ${PN}
		doicon -s 64 "${DISTDIR}"/${PN}.png
		make_desktop_entry ${PN}
	fi
	use doc && dohtml -r docs/online/*

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
