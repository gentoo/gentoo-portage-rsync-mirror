# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kmidimon/kmidimon-0.7.4.ebuild,v 1.5 2011/10/28 23:35:26 abcd Exp $

EAPI=4
inherit kde4-base

DESCRIPTION="A MIDI monitor for ALSA sequencer"
HOMEPAGE="http://kmetronome.sourceforge.net/kmidimon/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

RDEPEND="
	media-libs/alsa-lib
	>=media-sound/drumstick-0.5
"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README TODO )

src_configure() {
	mycmakeargs=(
		-DSTATIC_DRUMSTICK=OFF
	)

	kde4-base_src_configure
}
