# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cutter/cutter-1.03-r1.ebuild,v 1.4 2011/12/12 07:08:56 vapier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="TCP/IP Connection cutting on Linux Firewalls and Routers"
HOMEPAGE="http://www.lowth.com/cutter/"
SRC_URI="http://www.lowth.com/cutter/software/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="amd64 ~ppc x86"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-debian.patch
	rm -f Makefile # implicit rules are better ;x
}

src_compile() {
	emake cutter CC="$(tc-getCC)" || die
}

src_install() {
	dosbin cutter || die
	dodoc README
	doman debian/cutter.8
}
