# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/keyutils/keyutils-1.4-r1.ebuild,v 1.3 2011/07/08 19:41:49 mattst88 Exp $

EAPI=3

inherit multilib eutils toolchain-funcs

DESCRIPTION="Linux Key Management Utilities"
HOMEPAGE="http://www.kernel.org/"
SRC_URI="http://people.redhat.com/~dhowells/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~arm-linux ~ia64-linux ~x86-linux"
IUSE=""

DEPEND="!prefix? ( >=sys-kernel/linux-headers-2.6.11 )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.2-makefile-fixup.patch
	sed -i \
		-e '/CFLAGS/s|:= -g -O2|+=|' \
		Makefile || die
}

src_configure() {
	:
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		|| die "emake failed"
}

src_install() {
	emake \
		DESTDIR="${ED}" \
		LIBDIR="/$(get_libdir)" \
		USRLIBDIR="/usr/$(get_libdir)" \
		install || die
	dodoc README

	gen_usr_ldscript libkeyutils.so
}
