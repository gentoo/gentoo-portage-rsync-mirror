# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pianobooster/pianobooster-0.6.4b.ebuild,v 1.1 2011/05/18 17:08:44 radhermit Exp $

EAPI="4"

inherit cmake-utils

MY_P=${PN}-src-${PV}
DESCRIPTION="A MIDI file player that teaches how to play the piano"
HOMEPAGE="http://pianobooster.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fluidsynth"

DEPEND="fluidsynth? ( media-sound/fluidsynth )
	media-libs/alsa-lib
	virtual/opengl
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4"
RDEPEND="${DEPEND}"

DOCS="ReleaseNote.txt ../README.txt"

PATCHES=( "${FILESDIR}"/${P}-cmake.patch )

S=${WORKDIR}/${MY_P}/src

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_use fluidsynth)
	)

	cmake-utils_src_configure
}
