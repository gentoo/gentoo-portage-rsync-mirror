# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/gummiboot/gummiboot-45.ebuild,v 1.2 2014/08/07 08:11:18 mgorny Exp $

EAPI=5

inherit eutils linux-info

DESCRIPTION="Minimalistic UEFI bootloader"
HOMEPAGE="http://freedesktop.org/wiki/Software/gummiboot/"
SRC_URI="http://dev.gentoo.org/~mgorny/dist/${P}.tar.xz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="sys-apps/util-linux"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	=sys-boot/gnu-efi-3.0s"

pkg_pretend() {
	# CONFIG_EFI_STUB  is required to boot a kernel with gummiboot
	local CONFIG_CHECK="~EFI_STUB"
	check_extra_config
}

src_prepare() {
	epatch_user
}
