# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mjpegtools/mjpegtools-2.0.1_rc1-r1.ebuild,v 1.1 2013/04/06 09:58:44 billie Exp $

EAPI=5

inherit flag-o-matic toolchain-funcs

MY_P=${P/_rc/RC}

DESCRIPTION="Tools for MJPEG video"
HOMEPAGE="http://mjpeg.sourceforge.net/"
SRC_URI="mirror://sourceforge/mjpeg/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd"
IUSE="dga dv gtk mmx png quicktime sdl sdlgfx static-libs v4l"
REQUIRED_USE="sdlgfx? ( sdl )"

RDEPEND="virtual/jpeg
	quicktime? ( media-libs/libquicktime )
	dv? ( >=media-libs/libdv-0.99 )
	png? ( media-libs/libpng:0= )
	dga? ( x11-libs/libXxf86dga )
	gtk? ( x11-libs/gtk+:2 )
	sdl? ( >=media-libs/libsdl-1.2.7-r3
		x11-libs/libX11
		x11-libs/libXt
		sdlgfx? ( media-libs/sdl-gfx )
	 )"

DEPEND="${RDEPEND}
	mmx? ( dev-lang/nasm )
	>=sys-apps/sed-4
	virtual/awk
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

pkg_pretend() {
	if has_version ">=sys-kernel/linux-headers-2.6.38" && use v4l; then
		ewarn "Current versions of mjpegtools only support V4L1 which is not available"
		ewarn "for kernel versions 2.6.38 and above. V4L1 will be disabled."
	fi
}

src_prepare() {
	sed -i -e '/ARCHFLAGS=/s:=.*:=:' configure
}

src_configure() {
	[[ $(gcc-major-version) -eq 3 ]] && append-flags -mno-sse2

	econf \
		--enable-compile-warnings \
		$(use_enable mmx simd-accel) \
		$(use_enable static-libs static) \
		--enable-largefile \
		$(use_with quicktime libquicktime) \
		$(use_with dv libdv) \
		$(use_with png libpng) \
		$(use_with dga) \
		$(use_with gtk) \
		$(use_with sdl libsdl) \
		$(use_with sdlgfx) \
		$(use_with v4l) \
		$(use_with sdl x)
}

src_install() {
	default

	dodoc mjpeg_howto.txt PLANS HINTS docs/FAQ.txt

	find "${D}" -name '*.la' -exec rm -rf '{}' '+' || die "la removal failed"
}

pkg_postinst() {
	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		elog "mjpegtools installs user contributed scripts which require additional"
		elog "dependencies not pulled in by the installation."
		elog "These have to be installed manually."
		elog "Currently known extra dpendencies are: ffmpeg, mencoder from mplayer,"
		elog "parts of transcode, mpeg2dec from libmpeg2, sox, toolame, vcdimager, python."
	fi
}
