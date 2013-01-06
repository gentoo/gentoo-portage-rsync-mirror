# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/asekey/asekey-3.7.ebuild,v 1.1 2013/01/05 21:11:29 alonbl Exp $

EAPI="4"

inherit eutils udev

DESCRIPTION="ASEKey USB SIM Card Reader"
HOMEPAGE="http://www.athena-scs.com/"
SRC_URI="${HOMEPAGE}/docs/reader-drivers/${PN}-${PV/./-}-tar.bz2 -> ${P}.tar.bz2"
LICENSE="BSD LGPL-2.1"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

RDEPEND="sys-apps/pcsc-lite[udev]"
RDEPEND="${RDEPEND}
	virtual/libusb:0"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}/${P}-bundle.patch"
	sed -i -e 's/GROUP="pcscd"/ENV{PCSCD}="1"/' "92_pcscd_${PN}.rules" || die
}

src_configure() {
	econf --with-udev-rules-dir="$(udev_get_udevdir)/rules.d"
}

src_install() {
	default
	dodoc ChangeLog README
}
