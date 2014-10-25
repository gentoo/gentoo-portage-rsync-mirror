# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/libu2f-host/libu2f-host-0.0-r1.ebuild,v 1.1 2014/10/25 15:57:52 flameeyes Exp $

EAPI=5

inherit autotools-utils udev

DESCRIPTION="Yubico Universal 2nd Factor (U2F) Host C Library"
HOMEPAGE="https://developers.yubico.com/libu2f-host/"
SRC_URI="https://developers.yubico.com/${PN}/Releases/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="kernel_linux"

RDEPEND="dev-libs/hidapi
	dev-libs/json-c"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	autotools-utils_src_prepare
	sed -i -e 's:|\([^0]\):|0\1:g' 70-u2f.rules || die
}

src_install() {
	autotools-utils_src_install

	if use kernel_linux; then
		udev_dorules 70-u2f.rules
	fi
}
