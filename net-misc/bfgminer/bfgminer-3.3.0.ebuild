# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bfgminer/bfgminer-3.3.0.ebuild,v 1.1 2013/10/22 16:25:24 blueness Exp $

EAPI="4"

inherit eutils

DESCRIPTION="Modular Bitcoin ASIC/FPGA/GPU/CPU miner in C"
HOMEPAGE="https://bitcointalk.org/?topic=168174"
SRC_URI="http://luke.dashjr.org/programs/bitcoin/files/${PN}/${PV}/${P}.tbz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~ppc64 ~x86"

IUSE="+adl avalon bitforce cpumining examples hardened icarus lm_sensors modminer ncurses +opencl proxy proxy_getwork proxy_stratum scrypt +udev unicode x6500 ztex"
REQUIRED_USE="
	|| ( avalon bitforce cpumining icarus modminer opencl proxy x6500 ztex )
	adl? ( opencl )
	lm_sensors? ( opencl )
	scrypt? ( || ( cpumining opencl ) )
	unicode? ( ncurses )
	proxy? ( || ( proxy_getwork proxy_stratum ) )
	proxy_getwork? ( proxy )
	proxy_stratum? ( proxy )
"

DEPEND="
	net-misc/curl
	ncurses? (
		sys-libs/ncurses[unicode?]
	)
	>=dev-libs/jansson-2
	net-libs/libblkmaker
	udev? (
		virtual/udev
	)
	lm_sensors? (
		sys-apps/lm_sensors
	)
	proxy_getwork? (
		net-libs/libmicrohttpd
	)
	proxy_stratum? (
		dev-libs/libevent
	)
	x6500? (
		virtual/libusb:1
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
	>=dev-libs/uthash-1.9.2
	sys-apps/sed
	cpumining? (
		amd64? (
			>=dev-lang/yasm-1.0.1
		)
		x86? (
			>=dev-lang/yasm-1.0.1
		)
	)
"

src_configure() {
	local CFLAGS="${CFLAGS}"
	local with_curses
	use hardened && CFLAGS="${CFLAGS} -nopie"

	if use ncurses; then
		if use unicode; then
			with_curses='--with-curses=ncursesw'
		else
			with_curses='--with-curses=ncurses'
		fi
	fi

	CFLAGS="${CFLAGS}" \
	econf \
		--docdir="/usr/share/doc/${PF}" \
		$(use_enable adl) \
		$(use_enable avalon) \
		$(use_enable bitforce) \
		$(use_enable cpumining) \
		$(use_enable icarus) \
		$(use_enable modminer) \
		$(use_with ncurses curses) \
		$(use_enable opencl) \
		$(use_enable scrypt) \
		--with-system-libblkmaker \
		$with_curses
		$(use_with udev libudev) \
		$(use_with lm_sensors sensors) \
		$(use_with proxy_getwork libmicrohttpd) \
		$(use_with proxy_stratum libevent) \
		$(use_enable x6500) \
		$(use_enable ztex)
}

src_install() {
	emake install DESTDIR="$D"
	if ! use examples; then
		rm -r "${D}/usr/share/doc/${PF}/rpc-examples"
	fi
}
