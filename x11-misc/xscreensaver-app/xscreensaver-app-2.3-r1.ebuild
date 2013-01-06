# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xscreensaver-app/xscreensaver-app-2.3-r1.ebuild,v 1.1 2010/08/27 17:21:28 xarthisius Exp $

EAPI=2

inherit toolchain-funcs

MY_PN=${PN/-a/.A}
MY_PN=${MY_PN/xs/XS}
MY_PN=${MY_PN/s/S}

DESCRIPTION="XScreenSaver dockapp for the Window Maker window manager."
SRC_URI=" http://www.asleep.net/download/${MY_PN}-${PV}.tar.gz"
HOMEPAGE="http://xscreensaverapp.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/libdockapp"
RDEPEND="${DEPEND}
	x11-misc/xscreensaver"

S=${WORKDIR}/${MY_PN}-${PV}

src_compile() {
	emake CC="$(tc-getCC)" LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	dobin ${MY_PN} || die
	dodoc README NEWS ChangeLog TODO AUTHORS || die
}
