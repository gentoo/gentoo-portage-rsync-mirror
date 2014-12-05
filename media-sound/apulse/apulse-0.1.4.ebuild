# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/apulse/apulse-0.1.4.ebuild,v 1.4 2014/12/05 14:34:12 mgorny Exp $

EAPI=5

inherit cmake-multilib

DESCRIPTION="PulseAudio emulation for ALSA"
HOMEPAGE="https://github.com/i-rinat/apulse"
SRC_URI="https://github.com/i-rinat/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT LGPL-2.1"
SLOT="0"

KEYWORDS="~amd64 ~x86"

# Tricky stuff, we want to support both gx86-multilib and emul-linux-x86.
DEPEND="
	|| (
		(
			dev-libs/glib:2[${MULTILIB_USEDEP}]
			media-libs/alsa-lib[${MULTILIB_USEDEP}]
		)
		amd64? ( abi_x86_32? ( !abi_x86_x32? (
			dev-libs/glib:2
			media-libs/alsa-lib
			app-emulation/emul-linux-x86-baselibs[-abi_x86_32(-)]
			app-emulation/emul-linux-x86-soundlibs[-abi_x86_32(-)]
		) ) )
	)"
RDEPEND="${DEPEND}
	!!media-plugins/alsa-plugins[pulseaudio]"

MULTILIB_CHOST_TOOLS=( /usr/bin/apulse )

multilib_src_configure() {
	local mycmakeargs="-DAPULSEPATH=${EPREFIX}/usr/$(get_libdir)/apulse"

	cmake-utils_src_configure
}
