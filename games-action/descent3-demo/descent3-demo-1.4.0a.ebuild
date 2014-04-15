# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/descent3-demo/descent3-demo-1.4.0a.ebuild,v 1.13 2014/04/15 11:41:41 ulm Exp $

EAPI=4

inherit eutils unpacker games

DESCRIPTION="Indoor/outdoor 3D combat with evil robotic mining spacecraft"
HOMEPAGE="http://www.lokigames.com/products/descent3/"
SRC_URI="mirror://lokigames/loki_demos/${PN}.run"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="mirror bindist strip"

DEPEND="games-util/loki_patch"
RDEPEND="sys-libs/glibc
	virtual/opengl
	x86? (
		x11-libs/libX11
		x11-libs/libXext
		=media-libs/libsdl-1.2* )
	amd64? (
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-compat
		app-emulation/emul-linux-x86-sdl
		>=sys-libs/lib-compat-loki-0.2 )"

dir="${GAMES_PREFIX_OPT}/${PN}"
QA_PREBUILT="${dir:1}/descent3_demo.x86
	${dir:1}/netgames/*.d3m"

S=${WORKDIR}

src_install() {
	local demo="data/demos/descent3_demo"
	local exe="descent3_demo.x86"

	loki_patch patch.dat data/ || die "loki patch failed"

	insinto "${dir}"
	exeinto "${dir}"
	doins -r "${demo}"/*
	doexe "${demo}/${exe}"

	# Required directory
	keepdir "${dir}"/missions

	# Fix for 2.6 kernel crash
	cd "${Ddir}"
	ln -sf ppics.hog PPics.Hog

	games_make_wrapper ${PN} "./${exe}" "${dir}"
	newicon "${demo}"/launch/box.png ${PN}.png
	make_desktop_entry ${PN} "Descent 3 (Demo)" ${PN}

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "To play the game run:"
	elog " descent3-demo"
	elog
	elog "If the game appears blank, then run it windowed with:"
	elog " descent3-demo -w"
	echo
}
