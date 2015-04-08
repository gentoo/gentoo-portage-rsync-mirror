# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usbmon/usbmon-5.ebuild,v 1.3 2012/11/18 14:03:40 ulm Exp $

DESCRIPTION="Userland for USB monitoring framework"
HOMEPAGE="http://people.redhat.com/zaitcev/linux/"
SRC_URI="${HOMEPAGE}/${P/-/.}.tar.gz"

LICENSE="GPL-2" # GPL-2 only
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="!=sys-apps/usbutils-0.72-r2"
S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	sed -i -e '/CFLAGS =/s, = , \+= ,g' "${S}"/Makefile
}

src_install() {
	dosbin usbmon
	doman usbmon.8
}
