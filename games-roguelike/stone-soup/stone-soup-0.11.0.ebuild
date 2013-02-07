# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/stone-soup/stone-soup-0.11.0.ebuild,v 1.5 2013/02/07 22:11:48 ulm Exp $

## TODO
# add sound support (no build switch, no sound files)

EAPI=4
VIRTUALX_REQUIRED="manual"
inherit eutils gnome2-utils virtualx games

MY_P="stone_soup-${PV}"
DESCRIPTION="Role-playing roguelike game of exploration and treasure-hunting in dungeons"
HOMEPAGE="http://crawl.develz.org/wordpress/"
SRC_URI="mirror://sourceforge/crawl-ref/Stone%20Soup/${PV}/${MY_P}-nodeps.tar.xz
	http://dev.gentoo.org/~hasufell/distfiles/${PN}.png
	http://dev.gentoo.org/~hasufell/distfiles/${PN}.svg"

# 3-clause BSD: mt19937ar.cc, MSVC/stdint.h
# 2-clause BSD: all contributions by Steve Noonan and Jesse Luehrs
# Public Domain|CC0: most of tiles
# MIT: json.cc/json.h, some .js files in webserver/static/scripts/contrib/
LICENSE="GPL-2 BSD BSD-2 public-domain CC0-1.0 MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug +tiles"
# test is broken
# see https://crawl.develz.org/mantis/view.php?id=6121
#RESTRICT="!debug? ( test )"
RESTRICT="test"

RDEPEND="
	dev-db/sqlite:3
	sys-libs/zlib
	tiles? (
		media-libs/freetype:2
		media-libs/libpng:0
		media-libs/libsdl[X,opengl,video]
		media-libs/sdl-image[png]
		)
	!tiles? ( sys-libs/ncurses )
	>=dev-lang/lua-5.1.0[deprecated]"
DEPEND="${RDEPEND}
	dev-lang/perl
	sys-devel/flex
	virtual/yacc
	tiles? (
		sys-libs/ncurses
		virtual/pkgconfig
		test? ( ${VIRTUALX_DEPEND} )
		)"

S=${WORKDIR}/${MY_P}/source

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch

#	if use test ; then
#		cp -av "${WORKDIR}/${MY_P}" "${WORKDIR}/${MY_P}_test" \
#			|| die "setting up test-dir failed"
#	fi
}

src_compile() {
	S_TEST=${WORKDIR}/${MY_P}_test/source

	# leave DATADIR at the top
	myemakeargs=(
		DATADIR="${GAMES_DATADIR}/${PN}"
		V=1
		prefix="${GAMES_PREFIX}"
		SAVEDIR="~/.crawl"
		$(usex debug "FULLDEBUG=y DEBUG=y" "")
		$(usex tiles "TILES=y" "")
	)

	emake ${myemakeargs[@]}

	# for test to work we need to compile with unset DATADIR
#	if use test ; then
#		emake ${myemakeargs[@]:1} -C "${S_TEST}"
#	fi
}

src_install() {
	emake ${myemakeargs[@]} DESTDIR="${D}" install

	# don't relocate docs, needed at runtime
	rm -rf "${D}${GAMES_DATADIR}"/${PN}/docs/license
	dodoc "${WORKDIR}"/${MY_P}/README.{txt,pdf}

	# icons and menu for graphical build
	if use tiles ; then
		doicon -s 48 "${DISTDIR}"/${PN}.png
		doicon -s scalable "${DISTDIR}"/${PN}.svg
		make_desktop_entry crawl
	fi

	prepgamesdirs
}

src_test() {
	$(usex tiles "X" "")emake ${myemakeargs[@]:1} -C "${S_TEST}" test
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst
	gnome2_icon_cache_update

	echo
	elog "Your old config folder under '~/.crawl' is not compatible"
	elog "with the new version. Remove it."
	echo
}

pkg_postrm() {
	gnome2_icon_cache_update
}
