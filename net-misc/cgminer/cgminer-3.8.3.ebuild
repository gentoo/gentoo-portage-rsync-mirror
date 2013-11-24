# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cgminer/cgminer-3.8.3.ebuild,v 1.1 2013/11/24 20:40:58 blueness Exp $

EAPI=5

inherit autotools flag-o-matic

DESCRIPTION="Bitcoin CPU/GPU/FPGA/ASIC miner in C"
HOMEPAGE="http://bitcointalk.org/?topic=28402.msg357369 http://github.com/ckolivas/cgminer"
SRC_URI="http://ck.kolivas.org/apps/cgminer/${P}.tar.bz2"
#SRC_URI="http://ck.kolivas.org/apps/cgminer/3.8/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="doc examples hardened ncurses
	avalon bflsc bitforce bitfury icarus klondike modminer"

REQUIRED_USE="|| ( avalon bflsc bitforce bitfury icarus klondike modminer )"

DEPEND="net-misc/curl
	dev-libs/jansson
	ncurses? ( sys-libs/ncurses )
	avalon? ( virtual/libusb:1 )
	bflsc? ( virtual/libusb:1 )
	bitforce? ( virtual/libusb:1 )
	bitfury? ( virtual/libusb:1 )
	icarus? ( virtual/libusb:1 )
	modminer? ( virtual/libusb:1 )"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
	use hardened && append-cflags "-nopie"

	econf $(use_with ncurses curses) \
		$(use_enable avalon) \
		$(use_enable bflsc) \
		$(use_enable bitforce) \
		$(use_enable bitfury) \
		$(use_enable icarus) \
		$(use_enable klondike) \
		$(use_enable modminer)
	# sanitize directories (is this still needed?)
	sed -i 's~^\(\#define CGMINER_PREFIX \).*$~\1"'"${EPREFIX}/usr/lib/cgminer"'"~' config.h
}

src_install() { # How about using some make install?
	dobin cgminer
	if use doc; then
		dodoc AUTHORS NEWS README API-README
		use icarus || use bitforce || use modminer && dodoc FPGA-README
		use avalon || use bflsc && dodoc ASIC-README
	fi

	if use modminer; then
		insinto /usr/lib/cgminer/modminer
		doins bitstreams/*.ncd
		dodoc bitstreams/COPYING_fpgaminer
	fi
	if use examples; then
		docinto examples
		dodoc api-example.php miner.php API.java api-example.c example.conf
	fi
}
