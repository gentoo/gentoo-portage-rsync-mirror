# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/exfat-utils/exfat-utils-0.9.8.ebuild,v 1.1 2012/08/27 07:07:23 ssuominen Exp $

EAPI=4
inherit scons-utils toolchain-funcs

DESCRIPTION="exFAT filesystem utilities"
HOMEPAGE="http://code.google.com/p/exfat/"
SRC_URI="http://exfat.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_compile() {
	tc-export CC
	escons CCFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin dump/dumpexfat label/exfatlabel mkfs/mkexfatfs fsck/exfatfsck
	dosym mkexfatfs /usr/bin/mkfs.exfat
	dosym exfatfsck /usr/bin/fsck.exfat

	doman */*.8
	dodoc ChangeLog
}
