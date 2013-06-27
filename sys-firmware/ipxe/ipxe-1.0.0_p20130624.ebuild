# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-firmware/ipxe/ipxe-1.0.0_p20130624.ebuild,v 1.4 2013/06/27 22:18:30 cardoe Exp $

EAPI=5

GIT_REV="936134ed460618e18cc05d677a442d43d5e739a1"
GIT_SHORT="936134e"

DESCRIPTION="Open source network boot (PXE) firmware"
HOMEPAGE="http://ipxe.org"
SRC_URI="https://git.ipxe.org/ipxe.git/snapshot/${GIT_REV}.tar.bz2 -> ${P}-${GIT_SHORT}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="iso +qemu undi usb vmware"

DEPEND="sys-devel/make
	dev-lang/perl
	sys-libs/zlib
	iso? (
		sys-boot/syslinux
		virtual/cdrtools
	)"
RDEPEND=""

S="${WORKDIR}/ipxe-${GIT_SHORT}/src"

src_prepare() {
	cat <<-EOF > "${S}"/config/local/general.h
#undef BANNER_TIMEOUT
#define BANNER_TIMEOUT 0
EOF

	if use vmware; then
		cat <<-EOF >> "${S}"/config/local/general.h
#define VMWARE_SETTINGS
#define CONSOLE_VMWARE
EOF
	fi
}

src_compile() {
	export NO_WERROR=1
	if use qemu; then
		emake bin/808610de.rom # pxe-e1000.rom (old)
		emake bin/8086100e.rom # pxe-e1000.rom
		emake bin/80861209.rom # pxe-eepro100.rom
		emake bin/10500940.rom # pxe-ne2k_pci.rom
		emake bin/10222000.rom # pxe-pcnet.rom
		emake bin/10ec8139.rom # pxe-rtl8139.rom
		emake bin/1af41000.rom # pxe-virtio.rom
		fi

	if use vmware; then
		emake bin/8086100f.mrom # e1000
		emake bin/808610d3.mrom # e1000e
		emake bin/10222000.mrom # vlance
		emake bin/15ad07b0.rom # vmxnet3
	fi

	use iso && emake bin/ipxe.iso
	use undi && emake bin/undionly.kpxe
	use usb && emake bin/ipxe.usb
}

src_install() {
	insinto /usr/share/ipxe/

	if use qemu || use vmware; then
		doins bin/*.rom
	fi
	use vmware && doins bin/*.mrom
	use iso && doins bin/*.iso
	use undi && doins bin/*.kpxe
	use usb && doins bin/*.usb
}
