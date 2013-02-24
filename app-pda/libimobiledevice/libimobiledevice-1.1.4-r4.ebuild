# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libimobiledevice/libimobiledevice-1.1.4-r4.ebuild,v 1.4 2013/02/24 12:15:36 ago Exp $

EAPI=5
inherit autotools eutils

DESCRIPTION="Support library to communicate with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://www.libimobiledevice.org/"
SRC_URI="http://www.libimobiledevice.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86"
IUSE="gnutls"

RDEPEND=">=app-pda/libplist-1.8-r1
	>=app-pda/usbmuxd-1.0.8
	gnutls? (
		dev-libs/libgcrypt
		>=dev-libs/libtasn1-1.1
		>=net-libs/gnutls-2.2.0
		)
	!gnutls? ( dev-libs/openssl:0 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS NEWS README"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-openssl.patch \
		"${FILESDIR}"/${P}-HOME-segfault.patch \
		"${FILESDIR}"/${P}-property_list_service-do-not-strip-non-ASCII-charact.patch

	eautoreconf
}

src_configure() {
	# Disable python support wrt #451044, look at -1.1.4-r2
	# from Attic if you need to restore it.

	local myconf
	use gnutls && myconf='--disable-openssl'

	econf \
		--disable-static \
		--without-cython \
		${myconf}
}

src_install() {
	default
	dohtml docs/html/*

	prune_libtool_files --all
}
