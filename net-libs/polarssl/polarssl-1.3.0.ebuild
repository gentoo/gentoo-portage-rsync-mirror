# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/polarssl/polarssl-1.3.0.ebuild,v 1.8 2013/10/13 13:20:28 jer Exp $

EAPI=5

inherit eutils multilib toolchain-funcs

DESCRIPTION="Cryptographic library for embedded systems"
HOMEPAGE="http://polarssl.org/"
SRC_URI="http://polarssl.org/download/${P}-gpl.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm hppa ~ppc ppc64 ~s390 sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE="examples havege sse2 static-libs zlib"

RDEPEND="zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}"

enable_polarssl_option() {
	local myopt="$@"
	# check that config.h syntax is the same at version bump
	sed -i \
		-e "/define ${myopt}/{n; s/$/\n#define ${myopt}/}" \
		include/polarssl/config.h || die
}

src_prepare() {
	sed -i '/.SILENT:/d' Makefile */Makefile || die
	epatch "${FILESDIR}"/${PN}-cflags.patch

	use sse2 && enable_polarssl_option POLARSSL_HAVE_SSE2
	use zlib && enable_polarssl_option POLARSSL_ZLIB_SUPPORT
	use havege && enable_polarssl_option POLARSSL_HAVEGE_C
}

src_compile() {
	tc-export CC AR
	emake -C library OFLAGS="-fPIC" libpolarssl.so

	if use examples ; then
		emake -C programs OFLAGS="" $(usex zlib "ZLIB=1" "") all
	fi
	ln -s libpolarssl.so library/libpolarssl.so.0 || die
}

src_test() {
	cd programs || die
	emake test/selftest $(usex zlib "ZLIB=1" "") || die "emake selftest failed"
	LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:../library" ./test/selftest || die "selftest failed"
	cd "${S}" || die
	LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:../library" emake check $(usex zlib "ZLIB=1" "")
}

src_install() {
	insinto /usr/include/polarssl
	doins include/polarssl/*.h
	dolib.so library/libpolarssl.so
	ln -s libpolarssl.so "${D%/}"/usr/$(get_libdir)/libpolarssl.so.0 || die
	use static-libs && dolib.a library/libpolarssl.a

	local p e
	if use examples ; then
		for p in programs/*/* ; do
			if [[ -x "${p}" && ! -d "${p}" ]] ; then
				f=polarssl_`basename "${p}"`
				newbin "${p}" "${f}"
			fi
		done
		for e in aes hash pkey ssl test ; do
			docinto "${e}"
			dodoc programs/"${e}"/*.c
			dodoc programs/"${e}"/*.txt
		done
	fi
}
