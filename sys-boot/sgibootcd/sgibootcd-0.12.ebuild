# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/sgibootcd/sgibootcd-0.12.ebuild,v 1.3 2011/02/06 22:21:48 leio Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Creates burnable CD images for SGI LiveCDs"
HOMEPAGE="ftp://ftp.linux-mips.org/pub/linux/mips/people/skylark/"
SRC_URI="ftp://ftp.linux-mips.org/pub/linux/mips/people/skylark/${P}.tar.bz2"
LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~mips"
IUSE=""
RDEPEND=""
DEPEND=""
RESTRICT=""

src_compile() {
	local mycc="$(tc-getCC) ${CFLAGS}"

	[ -f "${S}/sgibootcd" ] && rm -f "${S}"/sgibootcd
	einfo "${mycc} sgibootcd.c -o sgibootcd"
	${mycc} sgibootcd.c -o sgibootcd
}

src_install() {
	dobin "${S}"/sgibootcd
}
