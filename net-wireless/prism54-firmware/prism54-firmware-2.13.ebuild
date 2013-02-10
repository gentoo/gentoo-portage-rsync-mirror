# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/prism54-firmware/prism54-firmware-2.13.ebuild,v 1.10 2013/02/10 08:49:55 ssuominen Exp $

EAPI=5

DESCRIPTION="firmware for Intersil Prism GT / Prism Duette (including USB) wireless chipsets"
HOMEPAGE="http://wireless.kernel.org/en/users/Drivers/p54"
SRC_URI="http://daemonizer.de/prism54/prism54-fw/fw-softmac/2.13.12.0.arm
	http://daemonizer.de/prism54/prism54-fw/fw-usb/2.13.1.0.lm86.arm
	http://daemonizer.de/prism54/prism54-fw/fw-usb/2.13.24.0.lm87.arm
	http://daemonizer.de/prism54/prism54-fw/stlc4560/2.13.12.0.a.5.2.arm"

RESTRICT="mirror"

LICENSE="as-is" # as-is is bs here, google for "prism 54 firmware license"
SLOT="1"
KEYWORDS="amd64 ppc x86"
IUSE=""

S=${WORKDIR}

src_unpack() { :; }

src_install() {
	dodir /lib/firmware
	insinto /lib/firmware
	newins "${DISTDIR}"/2.13.12.0.a.5.2.arm 3826.arm
	newins "${DISTDIR}"/2.13.24.0.lm87.arm isl3887usb
	newins "${DISTDIR}"/2.13.1.0.lm86.arm isl3886usb
	newins "${DISTDIR}"/2.13.12.0.arm isl3886pci
}
