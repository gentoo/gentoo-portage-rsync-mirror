# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/apulse/apulse-0.1.2-r2.ebuild,v 1.1 2014/11/14 20:48:46 axs Exp $

EAPI=5

inherit cmake-multilib

DESCRIPTION="PulseAudio emulation for ALSA"
HOMEPAGE="https://github.com/i-rinat/apulse"
SRC_URI="https://github.com/i-rinat/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT LGPL-2.1"
SLOT="0"

KEYWORDS="~amd64 ~x86"

DEPEND="media-libs/alsa-lib[${MULTILIB_USEDEP}]
	dev-libs/glib:2
	!media-sound/pulseaudio
	amd64? ( abi_x86_32? (
		!app-emulation/emul-linux-x86-soundlibs[-abi_x86_32(-)]
		!app-emulation/emul-linux-x86-soundlibs[abi_x86_32(-),pulseaudio(-)]
		|| (
			dev-libs/glib:2[abi_x86_32(-)]
			app-emulation/emul-linux-x86-baselibs[-abi_x86_32(-)]
		)
	) )
"
RDEPEND="${DEPEND}"

MULTILIB_CHOST_TOOLS=( /usr/bin/apulse )

multilib_src_configure() {
	local mycmakeargs="-DAPULSEPATH=${EPREFIX}/usr/$(get_libdir)"

	cmake-utils_src_configure
}
