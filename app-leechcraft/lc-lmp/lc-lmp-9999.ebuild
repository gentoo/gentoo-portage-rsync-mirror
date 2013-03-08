# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-lmp/lc-lmp-9999.ebuild,v 1.1 2013/03/08 22:02:05 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="LeechCraft Media Player, Phonon-based audio/video player."

SLOT="0"
KEYWORDS=""
IUSE="debug +graffiti kde +mpris +mp3tunes"

DEPEND="~app-leechcraft/lc-core-${PV}
		graffiti? ( media-libs/flac )
		kde? ( media-libs/phonon )
		!kde? ( dev-qt/qtphonon:4 )
		media-libs/taglib
		mpris? ( dev-qt/qtdbus:4 )
		dev-qt/qtdeclarative:4"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs="
		$(cmake-utils_use_enable graffiti LMP_GRAFFITI)
		$(cmake-utils_use_enable mpris LMP_MPRIS)
		$(cmake-utils_use_enable mp3tunes LMP_MP3TUNES)"
	cmake-utils_src_configure
}
