# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/logitech-applet/logitech-applet-0.4_pre1-r2.ebuild,v 1.6 2010/06/06 06:19:19 ssuominen Exp $

inherit eutils

MY_P=${P/_pre/test}
MY_P=${MY_P/-applet/_applet}

DESCRIPTION="Control utility for some special features of some special
			Logitech USB mice!"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="=virtual/libusb-0*"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/logitech_applet-mx518.patch" || die "Failed to apply
		patch"
	epatch "${FILESDIR}/add-new-id-of-mx300.patch" || die "Failed to apply
		patch"
}

src_install() {
	dosbin logitech_applet
	dodoc AUTHORS ChangeLog README doc/article.txt
}
