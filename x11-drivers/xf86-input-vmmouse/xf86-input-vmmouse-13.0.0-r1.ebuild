# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-vmmouse/xf86-input-vmmouse-13.0.0-r1.ebuild,v 1.3 2015/02/19 08:52:30 ago Exp $

EAPI=5

inherit xorg-2

DESCRIPTION="VMWare mouse input driver"
IUSE=""
KEYWORDS="amd64 x86 ~amd64-fbsd ~x86-fbsd"

RDEPEND=""
DEPEND="${RDEPEND}
	x11-proto/randrproto"

PATCHES=(
	"${FILESDIR}"/${P}-add-missing-include.patch
)

pkg_setup() {
	XORG_CONFIGURE_OPTIONS=(
		--with-hal-bin-dir=/punt
		--with-hal-callouts-dir=/punt
		--with-hal-fdi-dir=/punt
	)

	xorg-2_pkg_setup
}

src_install() {
	xorg-2_src_install
	rm -rf "${ED}"/punt
}
