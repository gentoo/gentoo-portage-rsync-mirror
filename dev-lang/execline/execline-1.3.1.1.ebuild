# Copyright 2013-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/execline/execline-1.3.1.1.ebuild,v 1.1 2014/11/04 03:50:42 williamh Exp $

EAPI=5

inherit multilib toolchain-funcs

DESCRIPTION="a non-interactive scripting language similar to SH"
HOMEPAGE="http://www.skarnet.org/software/execline/"
SRC_URI="http://www.skarnet.org/software/${PN}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

COMMON_DEPEND=">=dev-libs/skalibs-1.6.0.0"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}"

S=${WORKDIR}/admin/${P}

src_configure()
{
	echo $(tc-getCC) ${CFLAGS} > conf-compile/conf-cc
	echo $(tc-getCC) ${LDFLAGS} > conf-compile/conf-dynld
	echo /usr/$(get_libdir)/execline > conf-compile/conf-install-library
	echo /$(get_libdir) > conf-compile/conf-install-library.so
	echo $(tc-getCC) ${LDFLAGS} > conf-compile/conf-ld
	echo > conf-compile/conf-stripbins
	echo > conf-compile/conf-striplibs
	rm conf-compile/flag-slashpackage
	echo /usr/lib/skalibs/sysdeps > conf-compile/import
	echo /usr/include/skalibs > conf-compile/path-include
	echo /usr/$(get_libdir)/skalibs > conf-compile/path-library
	echo /$(get_libdir)/skalibs > conf-compile/path-library.so
}

src_compile()
{
	emake -j1
}

src_install()
{
	into /
	dobin command/*
	dolib.so library.so/*

	insinto /etc
	doins etc/*

	insinto /usr/include
	doins include/*

	if use static-libs ; then
		into /usr
		dolib.a library/*
	fi

	dodoc $(find doc -type f ! -name "*.html" ! -name "COPYING")
	dohtml -r doc/*
}
