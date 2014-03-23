# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/asapm/asapm-3.1-r1.ebuild,v 1.1 2014/03/23 17:32:23 kensington Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="APM monitor for AfterStep"
HOMEPAGE="http://tigr.net/afterstep/applets/"
SRC_URI="http://www.tigr.net/afterstep/download/asapm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc -sparc ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXpm"

DEPEND="${RDEPEND}
	x11-proto/xproto"

pkg_setup() {
	tc-export CC
}

src_prepare() {
	epatch "${FILESDIR}/${P}-ldflags.patch"
}

src_install() {
	dobin asapm
	newman asapm.man asapm.1
	dodoc CHANGES README TODO NOTES
}
