# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/heretic2-demo/heretic2-demo-1.06a.ebuild,v 1.13 2014/06/27 11:42:54 mgorny Exp $
EAPI=4

inherit eutils unpacker multilib games

DESCRIPTION="Third-person classic magical action-adventure game"
HOMEPAGE="http://www.lokigames.com/products/heretic2/
	http://www.hereticii.com/"
SRC_URI="mirror://lokigames/loki_demos/${PN}.run"

LICENSE="LOKI-EULA"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="strip"
QA_TEXTRELS="${GAMES_PREFIX_OPT:1}/heretic2-demo/ref_glx.so"

DEPEND="games-util/loki_patch"
RDEPEND="
	|| (
		(
			x11-libs/libX11[abi_x86_32(-)]
			x11-libs/libXext[abi_x86_32(-)]
		)
		amd64? (
			app-emulation/emul-linux-x86-xlibs[-abi_x86_32(-)]
		)
	)"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}
QA_PREBUILT="${dir:1}/*"

src_install() {
	ABI=x86

	local demo="data/demos/heretic2_demo"
	local exe="heretic2_demo.x86"

	loki_patch patch.dat data/ || die "loki patch failed"

	# Remove bad opengl library
	rm -r "${demo}/gl_drivers/"

	# Change to safe default of 800x600 and option of normal opengl driver
	sed -i "${demo}"/base/default.cfg \
		-e "s:fullscreen \"1\":fullscreen \"1\"\nset vid_mode \"4\":" \
		-e "s:libGL:/usr/$(get_libdir)/libGL:" \
		|| die "sed failed"

	insinto "${dir}"
	exeinto "${dir}"
	doins -r "${demo}"/*
	doexe "${demo}/${exe}"

	games_make_wrapper ${PN} "./${exe}" "${dir}" "${dir}"
	newicon "${demo}"/icon.xpm ${PN}.xpm
	make_desktop_entry ${PN} "Heretic 2 (Demo)" ${PN}

	prepgamesdirs
}
