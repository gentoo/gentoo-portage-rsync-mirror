# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libtorrent/libtorrent-0.12.9.ebuild,v 1.9 2012/05/05 02:54:28 jdhore Exp $

EAPI=4
inherit autotools-utils libtool

DESCRIPTION="BitTorrent library written in C++ for *nix"
HOMEPAGE="http://libtorrent.rakshasa.no/"
SRC_URI="http://libtorrent.rakshasa.no/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm hppa ~ia64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="debug ipv6 ssl test"

RDEPEND=">=dev-libs/libsigc++-2.2.2:2
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	test? ( dev-util/cppunit )"

# http://libtorrent.rakshasa.no/ticket/2617
RESTRICT=test

DOCS=( AUTHORS NEWS README )

src_prepare() {
	local PATCHES=(
		"${FILESDIR}"/${PN}-0.12.6-gcc44.patch
		"${FILESDIR}"/${PN}-0.12.7-test.patch
		"${FILESDIR}"/download_constructor.diff
	)
	autotools-utils_src_prepare
	elibtoolize
}

src_configure() {
	local myeconfargs=(
		--enable-aligned
		--with-posix-fallocate # configure will check for availability
		$(use_enable debug)
		$(use_enable ipv6)
		$(use_enable ssl openssl)
	)

	autotools-utils_src_configure
}
