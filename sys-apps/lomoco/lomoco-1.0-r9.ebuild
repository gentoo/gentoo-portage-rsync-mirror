# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lomoco/lomoco-1.0-r9.ebuild,v 1.5 2012/12/11 16:23:55 ssuominen Exp $

EAPI=4
inherit autotools eutils multilib toolchain-funcs udev

DESCRIPTION="Lomoco can configure vendor-specific options on Logitech USB mice."
HOMEPAGE="http://www.lomoco.org/"
SRC_URI="http://www.lomoco.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 x86"
IUSE=""

RDEPEND="virtual/libusb:0"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	cp -f "${FILESDIR}"/lomoco-pm-utils-r1 "${T}" || die
	sed -i -e "s|@UDEVDIR@|$(udev_get_udevdir)|" "${T}"/lomoco-pm-utils-r1 || die

	epatch \
		"${FILESDIR}"/${P}-gentoo-hardware-support.patch \
		"${FILESDIR}"/${P}-updated-udev.patch

	eautoreconf
}

src_compile() {
	emake
	emake udev-rules
}

src_install() {
	default

	insinto "$(udev_get_udevdir)"/rules.d
	newins udev/lomoco.rules 40-lomoco.rules

	exeinto "$(udev_get_udevdir)"
	newexe udev/udev.lomoco lomoco

	insinto /etc
	doins "${FILESDIR}"/lomoco.conf

	exeinto /etc/pm/sleep.d
	newexe "${T}"/lomoco-pm-utils-r1 lomoco
}
