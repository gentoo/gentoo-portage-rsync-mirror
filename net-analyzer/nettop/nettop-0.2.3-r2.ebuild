# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nettop/nettop-0.2.3-r2.ebuild,v 1.5 2012/07/29 17:21:52 armin76 Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="top like program for network activity"
SRC_URI="http://srparish.net/scripts/${P}.tar.gz"
HOMEPAGE="http://srparish.net/software/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="amd64 ~arm ppc x86"
IUSE=""

DEPEND="
	sys-libs/slang
	net-libs/libpcap"
RDEPEND="${DEPEND}"

pkg_setup() {
	ewarn "This is known to break with distcc, see bug #169245 for details"
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-gcc411.patch \
		"${FILESDIR}"/${P}-offbyone.patch
	tc-export CC
}

src_configure() {
	local myconf
	myconf="--prefix=/usr"
	./configure ${myconf} || die "configure failed"
}

src_install() {
	dosbin nettop || die
	dodoc ChangeLog README THANKS || die
}
