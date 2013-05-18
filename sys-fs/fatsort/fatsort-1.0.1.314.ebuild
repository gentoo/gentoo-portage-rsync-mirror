# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/fatsort/fatsort-1.0.1.314.ebuild,v 1.1 2013/05/18 08:09:17 billie Exp $

EAPI=5

inherit toolchain-funcs

DESCRIPTION="Sorts files on FAT16/32 partitions, ideal for basic audio players."
HOMEPAGE="http://fatsort.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_prepare() {
	sed -i -e '/^\(MANDIR=\|SBINDIR=\)/s|/usr/local|/usr|' \
		$(find ./ -name Makefile) || die

	sed -i -e 's/install#/install #/g' Makefile || die
}

src_compile() {
	emake CC=$(tc-getCC) LD=$(tc-getCC) \
		CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
		DESTDIR="${D}"
}
