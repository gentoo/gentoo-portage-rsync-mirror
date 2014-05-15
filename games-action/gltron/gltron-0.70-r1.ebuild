# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/gltron/gltron-0.70-r1.ebuild,v 1.8 2014/05/15 16:22:46 ulm Exp $

EAPI=2
inherit eutils games

DESCRIPTION="3d tron, just like the movie"
HOMEPAGE="http://gltron.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-source.tar.gz
	mirror://gentoo/${PN}.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="virtual/opengl
	media-libs/libpng
	media-libs/libsdl[sound,video]
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-sound[vorbis,mikmod]
	media-libs/smpeg
	media-libs/libmikmod"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-configure.patch \
		"${FILESDIR}"/${P}-prototypes.patch \
		"${FILESDIR}"/${P}-debian.patch
	sed -i \
		-e '/^gltron_LINK/s/$/ $(LDFLAGS)/' \
		Makefile.in \
		|| die 'sed failed'
}

src_configure() {
	# warn/debug/profile just modify CFLAGS, they aren't
	# real options, so don't utilize USE flags here
	egamesconf \
		--disable-warn \
		--disable-debug \
		--disable-profile
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog README
	doicon "${DISTDIR}"/${PN}.png
	make_desktop_entry ${PN} GLtron
	prepgamesdirs
}
