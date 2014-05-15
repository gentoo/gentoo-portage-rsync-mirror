# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/extreme-tuxracer/extreme-tuxracer-0.5_beta.ebuild,v 1.7 2014/05/15 16:22:21 ulm Exp $

EAPI=2
inherit eutils games

DESCRIPTION="High speed arctic racing game based on Tux Racer"
HOMEPAGE="http://www.extremetuxracer.com/"
SRC_URI="mirror://sourceforge/extremetuxracer/extremetuxracer-${PV/_/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls"

RDEPEND="virtual/opengl
	virtual/glu
	dev-lang/tcl
	media-libs/libsdl[X,sound,video]
	media-libs/sdl-mixer[mod,vorbis]
	media-libs/freetype:2
	media-libs/libpng
	x11-libs/libXmu
	x11-libs/libXi
	virtual/libintl"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	virtual/pkgconfig"

S=${WORKDIR}/${P/_}

src_prepare() {
	sed -i \
		-e '/^localedir/s:=.*:=@localedir@:' \
		src/Makefile.in \
		|| die "sed failed"

	epatch "${FILESDIR}"/${P}-libpng14.patch
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--localedir=/usr/share/locale \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog
	doicon "${FILESDIR}"/${PN}.svg
	make_desktop_entry etracer "Extreme Tux Racer"
	prepgamesdirs
}
