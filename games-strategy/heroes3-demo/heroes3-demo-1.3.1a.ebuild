# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/heroes3-demo/heroes3-demo-1.3.1a.ebuild,v 1.9 2014/10/13 16:12:03 mgorny Exp $

EAPI=5

inherit eutils unpacker games

MY_PN=${PN%-demo}

DESCRIPTION="turn-based 2D medieval combat"
HOMEPAGE="http://www.lokigames.com/products/heroes3/"
SRC_URI="mirror://lokigames/loki_demos/${PN}.run"

LICENSE="all-rights-reserved"
SLOT="0"
# Should also work on ppc
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror bindist strip"

DEPEND="games-util/loki_patch"
RDEPEND=">=sys-libs/lib-compat-loki-0.2
	|| (
		ppc? (
			x11-libs/libX11
		)
		!ppc? (
			x11-libs/libX11[abi_x86_32(-)]
		)
		amd64? (
			app-emulation/emul-linux-x86-xlibs[-abi_x86_32(-)]
		)
	)"

dir="${GAMES_PREFIX_OPT}/${PN}"
QA_PREBUILT="${dir:1}/*"

S=${WORKDIR}

src_install() {
	# Apply patch
	loki_patch patch.dat data/ || die "loki patch failed"

	local demo="data/demos/${MY_PN}_demo"

	local exe_stub="${MY_PN}_demo"
	if use ppc ; then
		exe="${exe_stub}.ppc"
	else
		exe="${exe_stub}.x86"
	fi

	insinto "${dir}"
	exeinto "${dir}"
	doins -r "${demo}"/*
	rm "${D}/${dir}"/{${exe_stub}*,*.sh} || die "rm executables failed"
	doexe "${demo}/${exe}"

	einfo "Linking libs provided by 'sys-libs/lib-compat-loki' to '${dir}'."
	dosym /lib/loki_ld-linux.so.2 "${dir}"/ld-linux.so.2
	dosym /usr/lib/loki_libc.so.6 "${dir}"/libc.so.6
	dosym /usr/lib/loki_libnss_files.so.2 "${dir}"/libnss_files.so.2

	games_make_wrapper ${PN} "./${exe}" "${dir}"
	newicon "${demo}/icon.xpm" ${PN}.png
	make_desktop_entry ${PN} "Heroes of Might and Magic III (Demo)" ${PN}

	prepgamesdirs
}
