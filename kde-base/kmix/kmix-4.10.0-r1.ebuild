# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmix/kmix-4.10.0-r1.ebuild,v 1.1 2013/02/08 14:20:51 thev00d00 Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE mixer gui"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="alsa debug canberra pulseaudio"

DEPEND="
	alsa? ( >=media-libs/alsa-lib-1.0.14a )
	canberra? ( media-libs/libcanberra )
	pulseaudio? ( >=media-sound/pulseaudio-0.9.12 )
"
RDEPEND="${DEPEND}"

PATCHES=(
	"$FILESDIR/${P}-mousewheel-step-313579.patch"
)

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with alsa)
		$(cmake-utils_use_with canberra)
		$(cmake-utils_use_with pulseaudio PulseAudio)
	)

	kde4-base_src_configure
}
