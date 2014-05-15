# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/lbreakout2/lbreakout2-2.6.3.ebuild,v 1.6 2014/05/15 16:29:19 ulm Exp $

EAPI=2
inherit autotools flag-o-matic eutils games

levels_V=20110610
themes_V=20070514

DESCRIPTION="Breakout clone written with the SDL library"
HOMEPAGE="http://lgames.sourceforge.net/index.php?project=LBreakout2"
SRC_URI=" mirror://sourceforge/lgames/${P}.tar.gz
	mirror://sourceforge/lgames/${PN}-levelsets-${levels_V}.tar.gz
	themes? ( mirror://sourceforge/lgames/${PN}-themes-${themes_V}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE="nls themes"

RDEPEND="media-libs/libpng
	sys-libs/zlib
	media-libs/libsdl[sound,joystick,video]
	media-libs/sdl-net
	media-libs/sdl-mixer
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${P}.tar.gz

	cd "${S}/client/levels"
	unpack ${PN}-levelsets-${levels_V}.tar.gz

	if use themes ; then
		mkdir "${WORKDIR}/themes"
		cd "${WORKDIR}/themes"
		unpack ${PN}-themes-${themes_V}.tar.gz

		# Delete a few duplicate themes (already shipped with lbreakout2
		# tarball). Some of them have different case than built-in themes, so it
		# is harder to just compare if the filename is the same.
		rm -f absoluteB.zip oz.zip moiree.zip
		for f in *.zip; do
			unzip -q "$f"  &&  rm -f "$f"  ||  die "unpacking ${f}"
		done
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	eautoreconf
}

src_configure() {
	filter-flags -O?
	egamesconf \
		--disable-dependency-tracking \
		--enable-sdl-net \
		--localedir=/usr/share/locale \
		--with-docdir="/usr/share/doc/${PF}/html" \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS README TODO ChangeLog

	if use themes ; then
		insinto "${GAMES_DATADIR}/lbreakout2/gfx"
		doins -r "${WORKDIR}/themes/"*  || die
	fi

	newicon client/gfx/win_icon.png lbreakout2.png
	make_desktop_entry lbreakout2 LBreakout2

	prepgamesdirs
}
