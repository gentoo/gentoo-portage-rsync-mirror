# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/xonotic/xonotic-0.5.0.ebuild,v 1.4 2011/11/11 09:20:06 phajdan.jr Exp $

EAPI=2
inherit eutils check-reqs games

MY_PN="${PN^}"
DESCRIPTION="Fork of Nexuiz, Deathmatch FPS based on DarkPlaces, an advanced Quake 1 engine"
HOMEPAGE="http://www.xonotic.org/"
SRC_URI="http://dl.xonotic.org/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="alsa debug dedicated doc sdl"

UIRDEPEND="
	media-libs/libogg
	media-libs/libtheora
	media-libs/libvorbis
	media-libs/libmodplug
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXxf86dga
	x11-libs/libXxf86vm
	virtual/opengl
	media-libs/freetype:2
	alsa? ( media-libs/alsa-lib )
	sdl? ( media-libs/libsdl[X,audio,joystick,opengl,video,alsa?] )"
UIDEPEND="
	x11-proto/xextproto
	x11-proto/xf86dgaproto
	x11-proto/xf86vidmodeproto
	x11-proto/xproto"
RDEPEND="
	sys-libs/zlib
	virtual/jpeg
	media-libs/libpng
	net-misc/curl
	~dev-libs/d0_blind_id-0.3
	!dedicated? ( ${UIRDEPEND} )"
DEPEND="${RDEPEND}
	!dedicated? ( ${UIDEPEND} )"

S=${WORKDIR}/${MY_PN}

pkg_setup() {
	CHECKREQS_DISK_BUILD="1200M"
	CHECKREQS_DISK_USR="950M"
	check-reqs_pkg_setup
	games_pkg_setup
}

src_prepare() {
	rm -rf misc/buildfiles/ # use system libs

	sed -i \
		-e "/^EXE_/s:darkplaces:${PN}:" \
		-e "s:-O3:${CFLAGS}:" \
		-e "/-lm/s:$: ${LDFLAGS}:" \
		-e '/^STRIP/s/strip/true/' \
		source/darkplaces/makefile.inc || die

	if ! use alsa; then
		sed -i \
			-e "/DEFAULT_SNDAPI/s:ALSA:OSS:" \
			source/darkplaces/makefile || die
	fi
}

src_compile() {
	local t="$(use debug && echo debug || echo release)"
	local d

	for d in sv-${t} $(use !dedicated && echo "cl-${t} $(use sdl && echo sdl-${t})")
	do
		emake \
			DP_LINK_TO_LIBJPEG=1 DP_FS_BASEDIR="${GAMES_DATADIR}/${PN}" \
			-C source/darkplaces ${d} || die
	done
}

src_install() {
	if ! use dedicated; then
		dogamesbin source/darkplaces/${PN}-glx || die
		newicon misc/logos/${PN}_icon.svg ${PN}.svg
		make_desktop_entry ${PN}-glx "${MY_PN} (GLX)"

		if use sdl; then
			dogamesbin source/darkplaces/${PN}-sdl || die
			make_desktop_entry ${PN}-sdl "${MY_PN} (SDL)"
		fi
	fi
	dogamesbin source/darkplaces/${PN}-dedicated || die

	dodoc Docs/*.txt
	use doc && dohtml -r Docs

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r key_0.d0pk server data || die
	prepgamesdirs
}
