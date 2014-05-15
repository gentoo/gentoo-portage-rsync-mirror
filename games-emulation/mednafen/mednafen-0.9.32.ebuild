# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mednafen/mednafen-0.9.32.ebuild,v 1.2 2014/05/15 16:37:57 ulm Exp $

EAPI=5
inherit autotools eutils games

DESCRIPTION="An advanced NES, GB/GBC/GBA, TurboGrafx 16/CD, NGPC and Lynx emulator"
HOMEPAGE="http://mednafen.sourceforge.net/"
SRC_URI="mirror://sourceforge/mednafen/${P}-wip.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="alsa altivec cjk debugger jack nls"

RDEPEND="virtual/opengl
	media-libs/libsndfile
	dev-libs/libcdio
	media-libs/libsdl[sound,joystick,opengl,video]
	media-libs/sdl-net
	sys-libs/zlib[minizip]
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${PN}

src_prepare() {
	sed -i \
		-e 's:$(datadir)/locale:/usr/share/locale:' \
		$(find . -name Makefile.am) \
		intl/Makefile.in || die
	epatch \
		"${FILESDIR}"/${P}-zlib.patch \
		"${FILESDIR}"/${P}-cflags.patch \
		"${FILESDIR}"/${P}-automake-1.13.patch
	eautoreconf
}

src_configure() {
	egamesconf \
		$(use_enable alsa) \
		$(use_enable altivec) \
		$(use_enable cjk cjk-fonts) \
		$(use_enable debugger) \
		$(use_enable jack) \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc Documentation/cheats.txt ChangeLog TODO
	dohtml Documentation/*
	prepgamesdirs
}
