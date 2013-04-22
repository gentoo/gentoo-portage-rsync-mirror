# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usbutils/usbutils-006-r1.ebuild,v 1.10 2013/04/22 17:09:03 ago Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit eutils python-single-r1

DESCRIPTION="USB enumeration utilities"
HOMEPAGE="http://linux-usb.sourceforge.net/"
SRC_URI="mirror://kernel/linux/utils/usb/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ia64 ~m68k ~mips ppc ppc64 s390 ~sh sparc x86 ~amd64-linux ~arm-linux ~x86-linux"
IUSE="python zlib"

RDEPEND="virtual/libusb:1=
	zlib? ( sys-libs/zlib:= )"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	virtual/pkgconfig"
RDEPEND="${RDEPEND}
	sys-apps/hwids
	python? ( ${PYTHON_DEPS} )"

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-stdint.patch

	sed -i -e '/^usbids/s:/usr/share:/usr/share/misc:' lsusb.py || die

	use python && python_fix_shebang lsusb.py
}

src_configure() {
	econf \
		--datarootdir="${EPREFIX}/usr/share" \
		--datadir="${EPREFIX}/usr/share/misc" \
		--disable-usbids \
		$(use_enable zlib)
}

src_install() {
	default
	newdoc usbhid-dump/NEWS NEWS.usbhid-dump

	use python || rm -f "${ED}"/usr/bin/lsusb.py
}
