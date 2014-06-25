# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/intrusion2/intrusion2-1.024.ebuild,v 1.2 2014/06/25 13:07:42 mgorny Exp $

EAPI=5

inherit eutils games

USELESS_ID="1370288626"
DESCRIPTION="Fast paced action sidescroller set in a sci-fi environment"
HOMEPAGE="http://intrusion2.com"
SRC_URI="intrusion2-${USELESS_ID}-bin"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="bindist fetch"

MYGAMEDIR=${GAMES_PREFIX_OPT}/${PN}
QA_PREBUILT="${MYGAMEDIR#/}/${PN}"

RDEPEND="
	amd64? (
		|| (
			app-emulation/emul-linux-x86-baselibs[-abi_x86_32(-)]
			dev-libs/glib:2[abi_x86_32(-)]
		)
		|| (
			app-emulation/emul-linux-x86-gtklibs[-abi_x86_32(-)]
			(
				dev-libs/atk[abi_x86_32(-)]
				x11-libs/gdk-pixbuf[abi_x86_32(-)]
				x11-libs/gtk+:2[abi_x86_32(-)]
				x11-libs/pango[abi_x86_32(-)]
			)
		)
		|| (
			app-emulation/emul-linux-x86-medialibs[-abi_x86_32(-)]
			(
				media-libs/gst-plugins-base[abi_x86_32(-)]
				media-libs/gstreamer[abi_x86_32(-)]
			)
		)
		|| (
			app-emulation/emul-linux-x86-xlibs[-abi_x86_32(-)]
			(
				media-libs/fontconfig[abi_x86_32(-)]
				media-libs/freetype[abi_x86_32(-)]
				x11-libs/libSM[abi_x86_32(-)]
				x11-libs/libX11[abi_x86_32(-)]
				x11-libs/libXext[abi_x86_32(-)]
				x11-libs/libXinerama[abi_x86_32(-)]
				x11-libs/libXtst[abi_x86_32(-)]
			)
		)
	)
	x86? (
		dev-libs/glib:2
		dev-libs/atk
		x11-libs/gdk-pixbuf
		x11-libs/gtk+:2
		x11-libs/pango
		media-libs/gst-plugins-base
		media-libs/gstreamer
		media-libs/fontconfig
		media-libs/freetype
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXinerama
		x11-libs/libXtst
	)"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please buy & download ${SRC_URI} from:"
	einfo "  ${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
	einfo
}

src_unpack() { :; }

src_install() {
	exeinto "${MYGAMEDIR}"
	newexe "${DISTDIR}"/${SRC_URI} ${PN}

	games_make_wrapper ${PN} "${MYGAMEDIR}/${PN}"
	make_desktop_entry ${PN}

	prepgamesdirs
}
