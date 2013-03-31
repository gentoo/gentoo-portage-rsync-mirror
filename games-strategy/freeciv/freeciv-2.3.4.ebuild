# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freeciv/freeciv-2.3.4.ebuild,v 1.4 2013/03/31 17:49:56 ago Exp $

EAPI=5
inherit eutils gnome2-utils games-ggz games

DESCRIPTION="multiplayer strategy game (Civilization Clone)"
HOMEPAGE="http://www.freeciv.org/"
SRC_URI="mirror://sourceforge/freeciv/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE="auth dedicated ggz +gtk ipv6 nls readline sdl +sound"
REQUIRED_USE="!dedicated? ( || ( gtk sdl ) )"

RDEPEND="readline? ( sys-libs/readline )
	sys-libs/zlib
	app-arch/bzip2
	auth? ( virtual/mysql )
	!dedicated? (
		nls? ( virtual/libintl )
		gtk? ( x11-libs/gtk+:2 )
		sdl? (
			media-libs/libsdl[video]
			media-libs/sdl-image[png]
			media-libs/freetype:2
		)
		sound? (
			media-libs/libsdl[audio]
			media-libs/sdl-mixer[vorbis]
		)
		ggz? ( games-board/ggz-gtk-client )
		media-libs/libpng:0
	)"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	!dedicated? (
		nls? ( sys-devel/gettext )
		x11-proto/xextproto
	)"

src_prepare() {
	# install the .desktop in /usr/share/applications
	# install the icons in /usr/share/pixmaps
	sed -i \
		-e 's:^.*\(desktopfiledir = \).*:\1/usr/share/applications:' \
		-e 's:^\(icon[0-9]*dir = \)$(prefix)\(.*\):\1/usr\2:' \
		-e 's:^\(icon[0-9]*dir = \)$(datadir)\(.*\):\1/usr/share\2:' \
		client/Makefile.in \
		server/Makefile.in \
		modinst/Makefile.in \
		data/Makefile.in \
		data/icons/Makefile.in \
		|| die
}

src_configure() {
	local myclient myopts

	if use dedicated ; then
		myclient="no"
	else
		use sdl && myclient="${myclient} sdl"
		use gtk && myclient="${myclient} gtk"
		myopts=$(use_with ggz ggz-client)
	fi

	egamesconf \
		--localedir=/usr/share/locale \
		--with-ggzconfig=/usr/bin \
		--enable-noregistry="${GGZ_MODDIR}" \
		$(use_enable auth) \
		$(use_enable ipv6) \
		$(use_enable nls) \
		$(use_with readline) \
		$(use_enable sound sdl-mixer) \
		${myopts} \
		--enable-client="${myclient}"
}

src_install() {
	emake DESTDIR="${D}" install

	if use dedicated ; then
		rm -rf "${D}/usr/share/pixmaps"
		rm -f "${D}"/usr/share/man/man6/freeciv-{client,gtk2,sdl,xaw}*
	else
		# Create and install the html manual. It can't be done for dedicated
		# servers, because the 'freeciv-manual' tool is then not built. Also
		# delete freeciv-manual from the GAMES_BINDIR, because it's useless.
		# Note: to have it localized, it should be ran from _postinst, or
		# something like that, but then it's a PITA to avoid orphan files...
		./manual/freeciv-manual || die
		dohtml manual*.html
		if use sdl ; then
			make_desktop_entry freeciv-sdl "Freeciv (SDL)" freeciv-client
		else
			rm -f "${D}"/usr/share/man/man6/freeciv-sdl*
		fi
		rm -f "${D}"/usr/share/man/man6/freeciv-xaw*
	fi
	find "${D}" -name "freeciv-manual*" -delete

	dodoc ChangeLog NEWS doc/{BUGS,CodingStyle,HACKING,HOWTOPLAY,README*,TODO}
	rm -rf "${D}$(games_get_libdir)"

	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst
	games-ggz_update_modules
	gnome2_icon_cache_update
}

pkg_postrm() {
	games-ggz_update_modules
	gnome2_icon_cache_update
}
