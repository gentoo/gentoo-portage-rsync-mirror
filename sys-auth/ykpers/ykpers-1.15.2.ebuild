# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/ykpers/ykpers-1.15.2.ebuild,v 1.1 2014/08/19 02:33:08 zerochaos Exp $

EAPI=5

inherit eutils udev

DESCRIPTION="Library and tool for personalization of Yubico's YubiKey"
SRC_URI="http://yubico.github.io/yubikey-personalization/releases/${P}.tar.gz"
HOMEPAGE="https://github.com/Yubico/yubikey-personalization"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="BSD-2"
IUSE="static-libs consolekit"

RDEPEND=">=sys-auth/libyubikey-1.6
	virtual/libusb:1"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
RDEPEND="${RDEPEND}
	consolekit? ( sys-auth/consolekit[acl] )"

src_configure() {
	econf $(use_enable static-libs static)
}

DOCS=( AUTHORS ChangeLog NEWS README )

src_install() {
	default
	dodoc doc/*
	prune_libtool_files

	use consolekit && \
		udev_dorules 70-yubikey.rules
}
