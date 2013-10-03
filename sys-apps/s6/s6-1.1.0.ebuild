# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/s6/s6-1.1.0.ebuild,v 1.1 2013/10/02 23:09:29 williamh Exp $

EAPI=5

inherit multilib toolchain-funcs

DESCRIPTION="skarnet.org's small and secure supervision software suite"
HOMEPAGE="http://www.skarnet.org/software/s6/"
SRC_URI="http://www.skarnet.org/software/${PN}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND=">=dev-libs/skalibs-1.4.0
	>=dev-lang/execline-1.2.2"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}"

S=${WORKDIR}/admin/${P}

src_configure()
{
	echo $(tc-getCC) ${CFLAGS} > conf-compile/conf-cc
	echo $(tc-getCC) ${LDFLAGS} > conf-compile/conf-dynld
	echo /usr/$(get_libdir)/s6 > conf-compile/conf-install-library
	echo /$(get_libdir) > conf-compile/conf-install-library.so
	echo $(tc-getCC) ${LDFLAGS} > conf-compile/conf-ld
	echo > conf-compile/conf-stripbins
	echo > conf-compile/conf-striplibs
	rm conf-compile/flag-slashpackage
	echo /usr/lib/skalibs/sysdeps > conf-compile/import
	echo /usr/include/skalibs > conf-compile/path-include
	echo /usr/include >> conf-compile/path-include
	echo /usr/$(get_libdir)/skalibs > conf-compile/path-library
	echo /usr/$(get_libdir) >> conf-compile/path-library
	echo /$(get_libdir)/skalibs > conf-compile/path-library.so
	echo /$(get_libdir) >> conf-compile/path-library.so
}

src_compile()
{
	emake -j1
}

src_install()
{
	into /
	dobin command/*

	dodoc -r examples
	dohtml -r doc/*
}
