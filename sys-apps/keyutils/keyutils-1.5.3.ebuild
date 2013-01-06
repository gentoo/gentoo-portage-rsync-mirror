# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/keyutils/keyutils-1.5.3.ebuild,v 1.1 2011/09/02 17:41:30 vapier Exp $

EAPI="3"

inherit multilib eutils toolchain-funcs

DESCRIPTION="Linux Key Management Utilities"
HOMEPAGE="http://people.redhat.com/dhowells/keyutils/"
SRC_URI="http://people.redhat.com/dhowells/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~arm-linux ~ia64-linux ~x86-linux"
IUSE=""

DEPEND="!prefix? ( >=sys-kernel/linux-headers-2.6.11 )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.5.3-makefile-fixup.patch
	sed -i \
		-e '1iRPATH=' \
		-e '/^C.*FLAGS/s|:=|+=|' \
		-e 's:-Werror::' \
		-e '/^BUILDFOR/s:=.*:=:' \
		-e "/^LIBDIR/s:=.*:=/usr/$(get_libdir):" \
		-e '/^USRLIBDIR/s:=.*:=$(LIBDIR):' \
		Makefile || die
}

src_configure() {
	tc-export CC
}

src_install() {
	emake DESTDIR="${ED}" install || die
	dodoc README
	gen_usr_ldscript -a keyutils
}
