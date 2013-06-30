# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/fatsort/fatsort-1.1.1.ebuild,v 1.3 2013/06/30 18:17:28 ago Exp $

EAPI=5

inherit toolchain-funcs

SVN_REV=336
MY_P=${P}.${SVN_REV}

DESCRIPTION="Sorts files on FAT16/32 partitions, ideal for basic audio players."
HOMEPAGE="http://fatsort.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

DEPEND="test? ( dev-util/bbe sys-fs/dosfstools )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i -e '/^\(MANDIR=\|SBINDIR=\)/s|/usr/local|/usr|' \
		$(find ./ -name Makefile) || die
}

src_compile() {
	emake CC=$(tc-getCC) LD=$(tc-getCC) \
		CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
		DESTDIR="${D}"
}

src_test() {
	make tests
}
