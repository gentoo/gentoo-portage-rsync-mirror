# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/logitech-applet/logitech-applet-0.4_pre1-r3.ebuild,v 1.3 2010/06/06 17:04:58 ssuominen Exp $

EAPI=2
inherit eutils

MY_P=${P/_pre/test}
MY_P=${MY_P/-applet/_applet}

DESCRIPTION="Control utility for some special features of some special Logitech USB mice!"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/libusb:0"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/logitech_applet-mx518.patch \
		"${FILESDIR}"/logitech_applet-mx518-2.patch \
		"${FILESDIR}"/add-new-id-of-mx300.patch
}

src_install() {
	dosbin logitech_applet || die
	dodoc AUTHORS ChangeLog README doc/article.txt

	docinto examples
	dodoc "${FILESDIR}"/40-logitech_applet.rules
}
