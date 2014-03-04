# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/papers-please/papers-please-1.1.60.ebuild,v 1.1 2014/03/04 15:38:32 hasufell Exp $

EAPI=5

inherit eutils games

DESCRIPTION="A Dystopian Document Thriller"
HOMEPAGE="http://papersplea.se"
SRC_URI="papers-please_${PV}_i386.tar.gz"

LICENSE="PAPERS-PLEASE"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="fetch bindist"

QA_PREBUILT="${GAMES_PREFIX_OPT#/}/${PN}/*"

RDEPEND="
	amd64? (
		x11-libs/libX11[abi_x86_32]
		x11-libs/libXau[abi_x86_32]
		x11-libs/libXdmcp[abi_x86_32]
		x11-libs/libXext[abi_x86_32]
		x11-libs/libXxf86vm[abi_x86_32]
		x11-libs/libdrm[abi_x86_32]
		x11-libs/libxcb[abi_x86_32]
		virtual/opengl[abi_x86_32]
	)
	x86? (
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/libXext
		x11-libs/libXxf86vm
		x11-libs/libdrm
		x11-libs/libxcb
		virtual/opengl
	)"

S=${WORKDIR}/${PN}

pkg_nofetch() {
	einfo
	einfo "Please buy & download \"${SRC_URI}\" from:"
	einfo "  ${HOMEPAGE}"
	einfo "and move/link it to \"${DISTDIR}\""
	einfo
}

src_prepare() {
	rm -v launch.sh LICENSE || die
	mv README "${T}"/README || die
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}

	insinto "${dir}"
	doins -r *
	fperms +x "${dir}"/PapersPlease

	games_make_wrapper ${PN} "./PapersPlease" "${dir}" "${dir}"
	make_desktop_entry ${PN} "Papers, Please"

	dodoc "${T}"/README

	prepgamesdirs
}
