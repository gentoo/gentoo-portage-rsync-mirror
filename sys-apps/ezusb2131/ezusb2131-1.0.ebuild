# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ezusb2131/ezusb2131-1.0.ebuild,v 1.6 2011/06/06 00:26:19 robbat2 Exp $

inherit linux-mod

MY_P=${PN/e/E}-${PV}
DESCRIPTION="This is a firmware uploader for EZ-USB devices"
HOMEPAGE="http://ezusb2131.sourceforge.net/"
SRC_URI="mirror://sourceforge/ezusb2131/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="sys-apps/hotplug"

S=${WORKDIR}/Ezusb2131

pkg_setup() {
	if kernel_is -ge 2 6 ; then
		eerror "This kernel module is only for 2.4 kernels."
		eerror "See ${HOMEPAGE} for 2.6 support."
		die "2.4 kernel only"
	fi
}

src_compile() {
	make all || die
}

src_install() {
	sed -i \
		-e 's/INSTALLDIR = \/lib\/modules/INSTALLDIR = ${D}\/lib\/modules/' \
	    -e 's/depmod -a/#depmod -a/' \
		Makefile

	make install || die
	dodoc README AUTHORS
}
