# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpg123/mpg123-1.14.2.ebuild,v 1.8 2012/07/29 18:45:12 armin76 Exp $

EAPI=4
inherit toolchain-funcs libtool

DESCRIPTION="a realtime MPEG 1.0/2.0/2.5 audio player for layers 1, 2 and 3"
HOMEPAGE="http://www.mpg123.org/"
SRC_URI="http://www.mpg123.org/download/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="3dnow 3dnowext alsa altivec coreaudio ipv6 jack mmx nas oss portaudio pulseaudio sdl sse"

RDEPEND="alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )
	nas? ( media-libs/nas )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-sound/pulseaudio )
	sdl? ( media-libs/libsdl )
	sys-devel/libtool"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog NEWS NEWS.libmpg123 README )

src_prepare() {
	elibtoolize # for Darwin bundles
}

src_configure() {
	local _audio=dummy
	local _output=dummy
	local _cpu=generic_fpu

	for flag in nas portaudio sdl oss jack alsa pulseaudio coreaudio; do
		if use ${flag}; then
			_audio="${_audio} ${flag/pulseaudio/pulse}"
			_output=${flag/pulseaudio/pulse}
		fi
	done

	use altivec && _cpu=altivec

	if [[ $(tc-arch) == amd64 || ${ARCH} == x64-* ]]; then
		use sse && _cpu=x86-64
	elif use x86 && gcc-specs-pie ; then
		# Don't use any mmx, 3dnow, sse and 3dnowext #bug 164504
		_cpu=generic_fpu
	else
		use mmx && _cpu=mmx
		use 3dnow && _cpu=3dnow
		use sse && _cpu=x86
		use 3dnowext && _cpu=x86
	fi

	econf \
		--with-optimization=0 \
		--with-audio="${_audio}" \
		--with-default-audio=${_output} \
		--with-cpu=${_cpu} \
		--enable-network \
		$(use_enable ipv6)
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec sed -i -e "/^dependency_libs/s:=.*:='':" {} +
}
