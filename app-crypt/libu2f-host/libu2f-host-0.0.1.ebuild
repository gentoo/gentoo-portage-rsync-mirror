# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/libu2f-host/libu2f-host-0.0.1.ebuild,v 1.1 2014/11/05 16:57:17 zerochaos Exp $

EAPI=5

inherit autotools-utils linux-info udev

DESCRIPTION="Yubico Universal 2nd Factor (U2F) Host C Library"
HOMEPAGE="https://developers.yubico.com/libu2f-host/"
SRC_URI="https://developers.yubico.com/${PN}/Releases/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="kernel_linux static-libs systemd"

RDEPEND="dev-libs/hidapi
	dev-libs/json-c"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
RDEPEND="${RDEPEND}
	systemd? ( sys-apps/systemd[acl] )"

CONFIG_CHECK="~HIDRAW"

src_prepare() {
	autotools-utils_src_prepare
	sed -i -e 's:|\([^0]\):|0\1:g' 70-u2f.rules || die

	sed -e 's:GROUP="plugdev":TAG+="uaccess":g' 70-u2f.rules > 70-u2f-systemd.rules || die
}

src_configure() {
	autotools-utils_src_configure
	econf $(use_enable static-libs static)
}

src_install() {
	autotools-utils_src_install

	if use kernel_linux; then
		if use systemd; then
			udev_newrules 70-u2f-systemd.rules 70-u2f.rules
		else
			udev_dorules 70-u2f.rules
		fi
	fi
}
