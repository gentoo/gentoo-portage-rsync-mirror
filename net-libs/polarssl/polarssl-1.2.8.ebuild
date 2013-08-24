# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/polarssl/polarssl-1.2.8.ebuild,v 1.8 2013/08/24 15:54:53 ago Exp $

EAPI=2

inherit eutils multilib toolchain-funcs

DESCRIPTION="Cryptographic library for embedded systems"
HOMEPAGE="http://polarssl.org/"
SRC_URI="http://polarssl.org/download/${P}-gpl.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm hppa ppc ppc64 ~s390 ~sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE="examples sse2"

src_prepare() {
	sed -i '/.SILENT:/d' Makefile */Makefile
	epatch "${FILESDIR}"/${PN}-1.2.0-makefile.patch
	cd library
	if use sse2 ; then
		sed -i '15iCFLAGS += -DHAVE_SSE2 -fPIC' Makefile
	else
		sed -i '15iCFLAGS += -fPIC' Makefile
	fi
}

src_compile() {
	tc-export CC AR
	emake -C library libpolarssl.so || die "emake failed"

	if use examples ; then
		emake -C programs all || die "emake failed"
	fi
	ln -s libpolarssl.so library/libpolarssl.so.0
}

src_test() {
	cd programs
	emake test/selftest || die "emake selftest failed"
	LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:../library" ./test/selftest || die "selftest failed"
	cd "${S}"
	LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:../library" emake check || die
}

src_install() {
	insinto /usr/include/polarssl
	doins include/polarssl/*.h || die
	dolib.so library/libpolarssl.so || die
	ln -s libpolarssl.so "${D}"usr/$(get_libdir)/libpolarssl.so.0
	dolib.a library/libpolarssl.a || die

	if use examples ; then
		for p in programs/*/* ; do
			if [[ -x "${p}" && ! -d "${p}" ]] ; then
				f=polarssl_`basename "${p}"`
				newbin "${p}" "${f}" || die
			fi
		done
		for e in aes hash pkey ssl test ; do
			docinto "${e}"
			dodoc programs/"${e}"/*.c || die
			dodoc programs/"${e}"/*.txt || die
		done
	fi
}
