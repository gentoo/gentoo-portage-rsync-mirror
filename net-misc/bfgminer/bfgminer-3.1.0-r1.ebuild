# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bfgminer/bfgminer-3.1.0-r1.ebuild,v 1.1 2013/06/18 11:36:58 blueness Exp $

EAPI="4"

inherit eutils

DESCRIPTION="Modular Bitcoin ASIC/FPGA/GPU/CPU miner in C"
HOMEPAGE="https://bitcointalk.org/?topic=168174"
SRC_URI="http://luke.dashjr.org/programs/bitcoin/files/${PN}/${PV}/${P}.tbz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+adl avalon bitforce cpumining examples hardened icarus lm_sensors modminer ncurses +opencl scrypt +udev x6500 ztex"
REQUIRED_USE="
	|| ( avalon bitforce cpumining icarus modminer opencl x6500 ztex )
	adl? ( opencl )
	lm_sensors? ( opencl )
	scrypt? ( || ( cpumining opencl ) )
"

DEPEND="
	net-misc/curl
	ncurses? (
		sys-libs/ncurses
	)
	>=dev-libs/jansson-2
	net-libs/libblkmaker
	udev? (
		virtual/udev
	)
	lm_sensors? (
		sys-apps/lm_sensors
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

src_prepare() {
	epatch "${FILESDIR}/3.1.0-Bugfix-opencl-Build-fpgautils-even-if-OpenCL-is-the-.patch"
	epatch "${FILESDIR}/3.1.0-Bugfix-opencl-Add-missing-include-for-fpgautils.h-ne.patch"
	NOSUBMODULES=1 ./autogen.sh
}

src_configure() {
	local CFLAGS="${CFLAGS}"
	use hardened && CFLAGS="${CFLAGS} -nopie"

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
		$(use_with udev libudev) \
		$(use_with lm_sensors sensors) \
		$(use_enable x6500) \
		$(use_enable ztex)
}

src_install() {
	emake install DESTDIR="$D"
	if ! use avalon; then
		rm "${D}/usr/share/doc/${PF}/README.ASIC"
	fi
	if ! { use modminer || use bitforce || use icarus || use ztex; }; then
		rm "${D}/usr/share/doc/${PF}/README.FPGA"
	fi
	if ! use opencl; then
		rm "${D}/usr/share/doc/${PF}/README.GPU"
	fi
	if ! use scrypt; then
		rm "${D}/usr/share/doc/${PF}/README.scrypt"
	fi
	if ! use examples; then
		rm -r "${D}/usr/share/doc/${PF}/rpc-examples"
	fi
}
