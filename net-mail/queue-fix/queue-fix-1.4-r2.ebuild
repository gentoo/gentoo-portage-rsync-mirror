# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/queue-fix/queue-fix-1.4-r2.ebuild,v 1.19 2011/02/06 10:13:54 leio Exp $

inherit eutils toolchain-funcs fixheadtails

DESCRIPTION="Qmail Queue Repair Application with support for big-todo"
HOMEPAGE="http://www.netmeridian.com/e-huss/"
SRC_URI="http://www.netmeridian.com/e-huss/${P}.tar.gz
	mirror://qmail/queue-fix-todo.patch"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc s390 sh sparc x86"
IUSE=""

DEPEND=""
PDEPEND="virtual/qmail"

src_unpack() {
	unpack ${P}.tar.gz
	epatch "${DISTDIR}"/queue-fix-todo.patch
	sed -i 's/^extern int errno;/#include <errno.h>/' ${S}/error.h
	ht_fix_file "${S}"/Makefile*
}

src_compile() {
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
	emake || die
}

src_install () {
	into /var/qmail
	dobin queue-fix || die
	into /usr
	dodoc README CHANGES
}
