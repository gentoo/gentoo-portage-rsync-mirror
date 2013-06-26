# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-soundlibs/emul-linux-x86-soundlibs-20130224-r2.ebuild,v 1.2 2013/06/26 21:49:01 aballier Exp $

EAPI=5
inherit emul-linux-x86

LICENSE="BSD FDL-1.2 GPL-2 LGPL-2.1 LGPL-2 MIT gsm public-domain"
KEYWORDS="-* ~amd64"
IUSE="abi_x86_32 alsa"

RDEPEND="~app-emulation/emul-linux-x86-baselibs-${PV}
	~app-emulation/emul-linux-x86-medialibs-${PV}
	!>=media-libs/libmikmod-3.2.0-r1[abi_x86_32]
	!>=sci-libs/fftw-3.3.3-r1[abi_x86_32]
	abi_x86_32? (
		>=media-libs/libogg-1.3.1[abi_x86_32(-)]
		>=media-libs/libvorbis-1.3.3-r1[abi_x86_32(-)]
		>=media-libs/libmodplug-0.8.8.4-r1[abi_x86_32(-)]
		>=media-sound/gsm-1.0.13-r1[abi_x86_32(-)]
		>=media-libs/webrtc-audio-processing-0.1-r1[abi_x86_32(-)]
		>=media-libs/alsa-lib-1.0.27.1[abi_x86_32(-)]
		>=media-libs/flac-1.2.1-r5[abi_x86_32(-)]
		>=media-libs/audiofile-0.3.6-r1[abi_x86_32(-)]
	)"

src_prepare() {
	_ALLOWED="${S}/etc/env.d"
	use alsa && _ALLOWED="${_ALLOWED}|${S}/usr/bin/aoss"
	ALLOWED="(${_ALLOWED})"

	emul-linux-x86_src_prepare

	if use alsa; then
		mv -f "${S}"/usr/bin/aoss{,32} || die
	fi

	# Remove migrated stuff.
	use abi_x86_32 && rm -f $(cat "${FILESDIR}/remove-native")
}
