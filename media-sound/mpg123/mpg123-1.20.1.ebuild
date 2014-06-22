# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpg123/mpg123-1.20.1.ebuild,v 1.1 2014/06/22 04:24:03 radhermit Exp $

EAPI=5
inherit eutils toolchain-funcs libtool multilib-minimal

DESCRIPTION="a realtime MPEG 1.0/2.0/2.5 audio player for layers 1, 2 and 3"
HOMEPAGE="http://www.mpg123.org/"
SRC_URI="http://www.mpg123.org/download/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="3dnow 3dnowext alsa altivec coreaudio int-quality ipv6 jack mmx nas oss portaudio pulseaudio sdl sse"

# No MULTILIB_USEDEP here since we only build libmpg123 for non native ABIs.
RDEPEND="app-admin/eselect-mpg123
	>=sys-devel/libtool-2.2.6b
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )
	nas? ( media-libs/nas )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-sound/pulseaudio )
	sdl? ( media-libs/libsdl )
	abi_x86_32? ( !<=app-emulation/emul-linux-x86-soundlibs-20130224-r9
					!app-emulation/emul-linux-x86-soundlibs[-abi_x86_32(-)] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog NEWS NEWS.libmpg123 README )

src_prepare() {
	elibtoolize # for Darwin bundles
}

multilib_src_configure() {
	local _audio=dummy
	local _output=dummy
	local _cpu=generic_fpu

	if $(multilib_is_native_abi) ; then
		for flag in nas portaudio sdl oss jack alsa pulseaudio coreaudio; do
			if use ${flag}; then
				_audio="${_audio} ${flag/pulseaudio/pulse}"
				_output=${flag/pulseaudio/pulse}
			fi
		done
	fi

	use altivec && _cpu=altivec

	if [[ $(tc-arch) == amd64 || ${ARCH} == x64-* ]]; then
		use sse && _cpu=x86-64
	elif use x86 && gcc-specs-pie ; then
		# Don't use any mmx, 3dnow, sse and 3dnowext #bug 164504
		_cpu=generic_fpu
	elif use x86-macos ; then
		# ASM doesn't work quite as expected with the Darwin linker
		_cpu=generic_fpu
	else
		use mmx && _cpu=mmx
		use 3dnow && _cpu=3dnow
		use sse && _cpu=x86
		use 3dnowext && _cpu=x86
	fi

	local myconf=""
	multilib_is_native_abi || myconf="${myconf} --disable-modules"

	ECONF_SOURCE="${S}" econf \
		--with-optimization=0 \
		--with-audio="${_audio}" \
		--with-default-audio=${_output} \
		--with-cpu=${_cpu} \
		--enable-network \
		$(use_enable ipv6) \
		--enable-int-quality=$(usex int-quality) \
		${myconf}

	if ! $(multilib_is_native_abi) ; then
		sed -i -e 's:src doc:src/libmpg123:' Makefile || die
	fi
}

multilib_src_install_all() {
	einstalldocs
	mv "${ED}"/usr/bin/mpg123{,-mpg123}
	find "${ED}" -name '*.la' -exec sed -i -e "/^dependency_libs/s:=.*:='':" {} +
}

pkg_postinst() {
	eselect mpg123 update ifunset
}

pkg_postrm() {
	eselect mpg123 update ifunset
}
