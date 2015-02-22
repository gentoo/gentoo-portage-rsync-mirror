# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/rename/rename-1.3.ebuild,v 1.26 2014/10/16 19:14:08 vapier Exp $

EAPI="5"

inherit toolchain-funcs eutils

DESCRIPTION="tool for easily renaming files"
HOMEPAGE="http://rename.sourceforge.net/"
SRC_URI="http://${PN}/sourceforge.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

src_prepare() {
	sed -i \
		-e '/^CFLAGS/s:-O3:@CFLAGS@:' \
		-e '/strip /s:.*::' \
		Makefile.in || die
	epatch "${FILESDIR}"/${P}-rename.patch
	epatch "${FILESDIR}"/${P}-build.patch
	epatch "${FILESDIR}"/${P}-gcc44.patch
	tc-export CC
}

src_install() {
	newbin rename renamexm
	newman rename.1 renamexm.1
	dodoc README ChangeLog
}

pkg_postinst() {
	ewarn "This has been renamed to 'renamexm' to avoid"
	ewarn "a naming conflict with sys-apps/util-linux."
}
