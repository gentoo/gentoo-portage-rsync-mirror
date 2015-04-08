# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usbmon/usbmon-6.ebuild,v 1.2 2012/11/18 14:03:40 ulm Exp $

EAPI=4

DESCRIPTION="Userland for USB monitoring framework"
HOMEPAGE="http://people.redhat.com/zaitcev/linux/"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"

LICENSE="GPL-2" # GPL-2 only
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="!=sys-apps/usbutils-0.72-r2"

src_unpack() {
	unpack ${A}
}

src_prepare() {
	sed -i -e '/CFLAGS =/s, = , \+= ,g' "${S}"/Makefile
}

src_install() {
	dosbin usbmon
	doman usbmon.8
	dodoc README
}
