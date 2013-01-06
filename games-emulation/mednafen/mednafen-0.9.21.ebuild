# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mednafen/mednafen-0.9.21.ebuild,v 1.3 2012/05/22 00:03:04 jdhore Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="An advanced NES, GB/GBC/GBA, TurboGrafx 16/CD, NGPC and Lynx emulator"
HOMEPAGE="http://mednafen.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-wip.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="alsa altivec cjk debug jack nls"

RDEPEND="virtual/opengl
	media-libs/libsndfile
	dev-libs/libcdio
	media-libs/libsdl[audio,joystick,video]
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
		$(find . -name 'Makefile.am') \
		intl/Makefile.in \
		|| die 'sed failed'
	sed -i \
		-e '/-ffast-math/d' \
		-e '/^AX_CFLAGS_GCC_OPTION.*OPTIMIZER_FLAGS/d' \
		configure.ac \
		|| die "sed failed"
	epatch "${FILESDIR}"/${P}-zlib.patch
	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable alsa) \
		$(use_enable altivec) \
		$(use_enable cjk cjk-fonts) \
		$(use_enable debug debugger) \
		$(use_enable jack) \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc Documentation/cheats.txt AUTHORS ChangeLog TODO
	dohtml Documentation/*
	prepgamesdirs
}
