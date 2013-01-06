# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/x2-demo/x2-demo-1.4.05.ebuild,v 1.4 2012/02/05 06:25:14 vapier Exp $

EAPI=1
inherit eutils unpacker games

MY_PN=${PN/-/_}

DESCRIPTION="Open-ended space opera with trading, building & fighting"
HOMEPAGE="http://www.linuxgamepublishing.com/info.php?id=x2"

# Patches are in http://updatefiles.linuxgamepublishing.com/x2-demo/
# Unversioned filename, grrr (is pre-patched).
SRC_URI="http://demofiles.linuxgamepublishing.com/x2/${MY_PN}.run"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror strip"

RDEPEND="media-libs/alsa-lib
	sys-libs/glibc
	x86? (
		media-libs/libsdl
		media-libs/openal
		sys-libs/zlib
		x11-libs/gtk+:2
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/libXext
		x11-libs/libXi )
	amd64? (
		app-emulation/emul-linux-x86-gtklibs
		app-emulation/emul-linux-x86-sdl )"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

src_unpack() {
	unpack_makeself ${MY_PN}.run
	unpack ./data.tar.gz
	rm -rf data.tar.gz lgp_* setup*

	mv bin "${T}" || die "mv bin"
}

src_install() {
	exeinto "${dir}"
	doexe "${T}"/bin/Linux/x86/x2_demo{,.dynamic} || die "doexe x2"

	insinto "${dir}"
	doins -r * || die "doins -r"

	keepdir "${dir}"/database

	# We don't support the dynamic version, even though we install it.
	games_make_wrapper ${PN} ./x2_demo "${dir}" "${dir}"
	newicon icon.xpm ${PN}.xpm || die "newicon failed"
	make_desktop_entry ${PN} "X2 - The Threat (Demo)" ${PN}

	prepgamesdirs
}
