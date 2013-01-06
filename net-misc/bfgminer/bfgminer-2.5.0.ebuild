# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bfgminer/bfgminer-2.5.0.ebuild,v 1.6 2012/12/03 02:26:16 ssuominen Exp $

EAPI="4"

inherit eutils

DESCRIPTION="Modular Bitcoin CPU/GPU/FPGA miner in C"
HOMEPAGE="https://bitcointalk.org/index.php?topic=78192.0"
SRC_URI="http://luke.dashjr.org/programs/bitcoin/files/${PN}/${PV}/${P}.tbz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"

IUSE="+adl altivec bitforce +cpumining examples hardened icarus modminer ncurses +opencl padlock sse2 sse2_4way sse4 +udev ztex"
REQUIRED_USE="
	|| ( bitforce cpumining icarus modminer opencl ztex )
	adl? ( opencl )
	altivec? ( cpumining ppc ppc64 )
	opencl? ( ncurses )
	padlock? ( cpumining || ( amd64 x86 ) )
	sse2? ( cpumining || ( amd64 x86 ) )
	sse4? ( cpumining amd64 )
"

DEPEND="
	net-misc/curl
	ncurses? (
		sys-libs/ncurses
	)
	dev-libs/jansson
	udev? (
		virtual/udev
	)
	ztex? (
		virtual/libusb:1
	)
"
RDEPEND="${DEPEND}
	opencl? (
		virtual/opencl
	)
"
DEPEND="${DEPEND}
	virtual/pkgconfig
	sys-apps/sed
	adl? (
		x11-libs/amd-adl-sdk
	)
	sse2? (
		>=dev-lang/yasm-1.0.1
	)
	sse4? (
		>=dev-lang/yasm-1.0.1
	)
"

src_prepare() {
	sed -i 's/\(^\#define WANT_.*\(SSE\|PADLOCK\|ALTIVEC\)\)/\/\/ \1/' miner.h
	ln -s /usr/include/ADL/* ADL_SDK/
}

src_configure() {
	local CFLAGS="${CFLAGS}"
	if ! use altivec; then
		sed -i 's/-faltivec//g' configure
	else
		CFLAGS="${CFLAGS} -DWANT_ALTIVEC=1"
	fi
	use padlock && CFLAGS="${CFLAGS} -DWANT_VIA_PADLOCK=1"
	if use sse2; then
		if use amd64; then
			CFLAGS="${CFLAGS} -DWANT_X8664_SSE2=1"
		else
			CFLAGS="${CFLAGS} -DWANT_X8632_SSE2=1"
		fi
	fi
	use sse2_4way && CFLAGS="${CFLAGS} -DWANT_SSE2_4WAY=1"
	use sse4 && CFLAGS="${CFLAGS} -DWANT_X8664_SSE4=1"
	use hardened && CFLAGS="${CFLAGS} -nopie"

	CFLAGS="${CFLAGS}" \
	econf \
		$(use_enable adl) \
		$(use_enable bitforce) \
		$(use_enable cpumining) \
		$(use_enable icarus) \
		$(use_enable modminer) \
		$(use_with ncurses curses) \
		$(use_enable opencl) \
		$(use_with udev libudev) \
		$(use_enable ztex)
	# sanitize directories
	sed -i 's~^\(\#define CGMINER_PREFIX \).*$~\1"'"${EPREFIX}/usr/lib/bfgminer"'"~' config.h
}

src_install() {
	dobin bfgminer
	dodoc AUTHORS NEWS README API-README
	if use icarus || use bitforce; then
		dodoc FPGA-README
	fi
	if use modminer; then
		insinto /usr/lib/bfgminer/modminer
		doins bitstreams/*.ncd
		dodoc bitstreams/COPYING_fpgaminer
	fi
	if use opencl; then
		insinto /usr/lib/bfgminer
		doins *.cl
	fi
	if use ztex; then
		insinto /usr/lib/bfgminer/ztex
		doins bitstreams/*.bit
		dodoc bitstreams/COPYING_ztex
	fi
	if use examples; then
		docinto examples
		dodoc api-example.php miner.php API.java api-example.c
	fi
}
