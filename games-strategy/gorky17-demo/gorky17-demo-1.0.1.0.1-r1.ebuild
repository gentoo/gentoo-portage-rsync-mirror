# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/gorky17-demo/gorky17-demo-1.0.1.0.1-r1.ebuild,v 1.2 2014/06/25 17:27:49 mgorny Exp $

EAPI=5

inherit eutils unpacker versionator games

MY_PN="gorky17"
MY_PV=$(replace_version_separator 2 '-')

DESCRIPTION="Horror conspiracy game mixing elements of strategy and role-playing"
HOMEPAGE="http://www.linuxgamepublishing.com/info.php?id=gorky17"
SRC_URI="http://demofiles.linuxgamepublishing.com/${MY_PN}/${MY_PN}_demo.run
	http://updatefiles.linuxgamepublishing.com/gorky17-demo/${PN}-${MY_PV}-x86.run"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="mirror bindist strip"

RDEPEND="
	|| (
		(
			>=media-libs/alsa-lib-1.0.27.2[abi_x86_32(-)]
			>=media-libs/libsdl-1.2.15-r4[abi_x86_32(-)]
			>=sys-libs/zlib-1.2.8-r1[abi_x86_32(-)]
			>=x11-libs/libX11-1.6.2[abi_x86_32(-)]
			>=x11-libs/libXau-1.0.7-r1[abi_x86_32(-)]
			>=x11-libs/libXdmcp-1.1.1-r1[abi_x86_32(-)]
			>=x11-libs/libXext-1.3.2[abi_x86_32(-)]
		)
		amd64? (
			(
				app-emulation/emul-linux-x86-baselibs[-abi_x86_32(-)]
				app-emulation/emul-linux-x86-sdl[-abi_x86_32(-)]
				app-emulation/emul-linux-x86-soundlibs[-abi_x86_32(-)]
				app-emulation/emul-linux-x86-xlibs[-abi_x86_32(-)]
			)
		)
	)"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

QA_EXECSTACK="${dir:1}/gorky17_demo ${dir:1}/gorky17_demo.dynamic"

src_unpack() {
	unpack_makeself ${MY_PN}_demo.run
	unpack ./data/data.tar.gz

	mkdir patch
	cd patch
	unpack_makeself ${PN}-${MY_PV}-x86.run
	cd "${S}"

	# Apply patch
	mv bin/Linux/x86/* .
	mv patch/*.sh .
	./patch/bin/Linux/x86/loki_patch patch/patch.dat . \
		|| die "loki_patch failed"

	rm -r update.sh *patch.sh data lgp_* patch setup* bin
}

src_install() {
	insinto "${dir}"
	doins -r *
	rm "${Ddir}"/${MY_PN}*

	exeinto "${dir}"
	doexe ${MY_PN}*

	games_make_wrapper ${PN} ./${MY_PN}_demo "${dir}" "${dir}"
	newicon icon.xpm ${PN}.xpm
	make_desktop_entry ${PN} "Gorky 17 (Demo)" ${PN}

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	elog "The instruction manual is available as:"
	elog "   http://demofiles.linuxgamepublishing.com/gorky17/manual.pdf"
	echo
}
