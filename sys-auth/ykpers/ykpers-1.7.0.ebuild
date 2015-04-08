# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/ykpers/ykpers-1.7.0.ebuild,v 1.1 2012/06/24 10:32:57 flameeyes Exp $

EAPI=4

inherit eutils

DESCRIPTION="Library and tool for personalization of Yubico's YubiKey"
SRC_URI="http://yubikey-personalization.googlecode.com/files/${P}.tar.gz"
HOMEPAGE="https://github.com/Yubico/yubikey-personalization"

KEYWORDS="~amd64"
SLOT="0"
LICENSE="BSD-2"
IUSE="static-libs"

RDEPEND=">=sys-auth/libyubikey-1.6
	virtual/libusb:1"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf $(use_enable static-libs static)
}

DOCS=( AUTHORS ChangeLog NEWS README )

src_install() {
	default
	dodoc doc/*
	prune_libtool_files
}
