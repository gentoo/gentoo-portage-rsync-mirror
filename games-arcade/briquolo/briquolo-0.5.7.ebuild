# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/briquolo/briquolo-0.5.7.ebuild,v 1.4 2014/07/23 07:07:25 tupone Exp $

inherit eutils games

DESCRIPTION="Breakout with 3D representation based on OpenGL"
HOMEPAGE="http://briquolo.free.fr/en/index.html"
SRC_URI="http://briquolo.free.fr/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls"

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	media-libs/libpng
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-libpng14.patch
	# no thanks we'll take care of it.
	sed -i \
		-e '/^SUBDIRS/s/desktop//' \
		Makefile.in \
		|| die "sed Makefile.in failed"
	sed -i \
		-e "/CXXFLAGS/s:-O3:${CXXFLAGS}:" \
		-e 's:=.*share/locale:=/usr/share/locale:' \
		configure \
		|| die "sed configure failed"
	sed -i \
		-e 's:$(datadir)/locale:/usr/share/locale:' \
		po/Makefile.in.in \
		|| die "sed Makefile.in.in failed"
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
	doicon desktop/briquolo.svg
	make_desktop_entry briquolo Briquolo
	prepgamesdirs
}
