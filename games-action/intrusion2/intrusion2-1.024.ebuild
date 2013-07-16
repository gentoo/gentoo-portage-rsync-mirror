# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/intrusion2/intrusion2-1.024.ebuild,v 1.1 2013/07/16 19:35:52 hasufell Exp $

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
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-gtklibs
		app-emulation/emul-linux-x86-medialibs
		app-emulation/emul-linux-x86-xlibs
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
