# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmikmod/libmikmod-3.3.3.ebuild,v 1.1 2013/10/26 07:21:43 aballier Exp $

EAPI=5
inherit eutils multilib-minimal

DESCRIPTION="A library to play a wide range of module formats"
HOMEPAGE="http://mikmod.sourceforge.net/"
SRC_URI="mirror://sourceforge/mikmod/${P}.tar.gz"

LICENSE="LGPL-2+ LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="+alsa altivec coreaudio debug oss sse2 static-libs +threads"

REQUIRED_USE="|| ( alsa oss coreaudio )"

RDEPEND="alsa? ( media-libs/alsa-lib:=[${MULTILIB_USEDEP}] )
	!${CATEGORY}/${PN}:2
	abi_x86_32? ( !<=app-emulation/emul-linux-x86-soundlibs-20130224-r3
					!app-emulation/emul-linux-x86-soundlibs[-abi_x86_32(-)] )"
DEPEND="${RDEPEND}
	oss? ( virtual/os-headers )"

multilib_src_configure() {
	local mysimd="--disable-simd"
	if use ppc || use ppc64 || use ppc-macos; then
		mysimd="$(use_enable altivec simd)"
	fi
	if use amd64 || use x86 || use x86-fbsd || use x86-freebsd || use amd64-linux || use x86-linux || use x86-macos; then
		mysimd="$(use_enable sse2 simd)"
	fi

	# nas: was disabled in 3.2.0 for being broken, unknown for 3.3.2
	# sdl, sdl2, openal: missing multilib supported ebuilds, temporarily disabled
	ECONF_SOURCE=${S} \
	econf \
		$(use_enable alsa) \
		--disable-nas \
		--disable-sdl \
		--disable-sdl2 \
		--disable-openal \
		$(use_enable oss) \
		$(use_enable coreaudio osx) \
		$(use_enable debug) \
		$(use_enable threads) \
		$(use_enable static-libs static) \
		--disable-dl \
		${mysimd}
}

multilib_src_install() {
	emake DESTDIR="${D}" install
	dosym ${PN}$(get_libname 3) /usr/$(get_libdir)/${PN}$(get_libname 2)
}

multilib_src_install_all() {
	dodoc AUTHORS NEWS README TODO
	dohtml docs/*.html
	prune_libtool_files
}
