# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/postal2mp-demo/postal2mp-demo-1407-r1.ebuild,v 1.6 2012/12/15 19:24:08 tupone Exp $

EAPI=2
inherit eutils unpacker multilib games

DESCRIPTION="You play the Postal Dude: Postal 2 is only as violent as you are"
HOMEPAGE="http://www.linuxgamepublishing.com/info.php?id=postal2"
SRC_URI="http://demofiles.linuxgamepublishing.com/postal2/postal2_demo.run"

LICENSE="postal2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="mirror strip"

RDEPEND="virtual/opengl
	sys-libs/glibc
	amd64? ( app-emulation/emul-linux-x86-sdl )
	x86? (
		media-libs/libsdl[X,opengl]
		media-libs/openal
	)"
DEPEND=""

QA_PREBUILT="${GAMES_PREFIX_OPT:1}/${PN}/System/*"

S=${WORKDIR}/data

src_unpack() {
	unpack_makeself
	mkdir data
	cd data
	unpack ./../postal2mpdemo.tar
	unpack ./../linux-specific.tar
}

src_install() {
	has_multilib_profile && ABI=x86

	dir=${GAMES_PREFIX_OPT}/${PN}

	insinto "${dir}"
	doins -r * || die "doins failed"
	fperms +x "${dir}"/System/{postal2,ucc}-bin || die "fperms failed"

	dosym /usr/$(get_libdir)/libopenal.so "${dir}"/System/openal.so || die
	dosym /usr/$(get_libdir)/libSDL-1.2.so.0 "${dir}"/System/libSDL-1.2.so.0 \
		|| die

	games_make_wrapper ${PN} ./postal2-bin "${dir}"/System .
	newicon ../postal2mpdemo.xpm ${PN}.xpm
	make_desktop_entry ${PN} "Postal 2: Share the Pain (Demo)"

	prepgamesdirs
}
