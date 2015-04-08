# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/libykneomgr/libykneomgr-0.1.6.ebuild,v 1.2 2014/10/25 15:53:47 flameeyes Exp $

EAPI=5

inherit autotools-utils udev

DESCRIPTION="YubiKey NEO CCID Manager C Library"
HOMEPAGE="https://developers.yubico.com/libykneomgr/"
SRC_URI="https://developers.yubico.com/${PN}/Releases/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="kernel_linux"

RDEPEND="sys-apps/pcsc-lite
	dev-libs/libzip"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
RDEPEND="${RDEPEND}
	>=app-crypt/ccid-1.4.18[usb]"

src_configure() {
	local myeconfargs=(
		--with-backend=pcsc
		--disable-static
	)

	autotools-utils_src_configure
}
