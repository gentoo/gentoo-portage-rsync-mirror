# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/keyutils/keyutils-1.2-r2.ebuild,v 1.8 2010/12/08 20:11:16 armin76 Exp $

inherit multilib eutils toolchain-funcs

DESCRIPTION="Linux Key Management Utilities"
HOMEPAGE="http://www.kernel.org/"
SRC_URI="http://people.redhat.com/~dhowells/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=">=sys-kernel/linux-headers-2.6.11"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PN}-1.2-makefile-fixup.patch
	cd "${S}"
	sed -i \
		-e '/CFLAGS/s|:= -g -O2|+=|' \
		Makefile || die
}

src_compile() {
	emake \
		CC=$(tc-getCC) \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		|| die "emake failed"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		LIBDIR="/$(get_libdir)" \
		USRLIBDIR="/usr/$(get_libdir)" \
		install || die
	dodoc README

	gen_usr_ldscript libkeyutils.so
}
