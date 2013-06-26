# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/crypto++/crypto++-5.6.2.ebuild,v 1.7 2013/06/26 03:04:41 ago Exp $

EAPI=5

inherit eutils flag-o-matic multilib toolchain-funcs

DESCRIPTION="C++ class library of cryptographic schemes"
HOMEPAGE="http://cryptopp.com"
SRC_URI="mirror://sourceforge/cryptopp/cryptopp${PV//.}.zip"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 ~sparc x86"
IUSE="static-libs"

DEPEND="app-arch/unzip
	sys-devel/libtool"

S=${WORKDIR}

src_prepare() {
	epatch "${FILESDIR}"/${P}-make.patch
}

src_compile() {
	# higher optimizations cause problems
	replace-flags -O? -O1
	filter-flags -fomit-frame-pointer

	emake -f GNUmakefile CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}" LIBDIR="$(get_libdir)"
}

src_test() {
	# ensure that all test vectors have Unix line endings
	local file
	for file in TestVectors/* ; do
		edos2unix ${file}
	done

	if ! emake CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}" test ; then
		eerror "Crypto++ self-tests failed."
		eerror "Try to remove some optimization flags and reemerge Crypto++."
		die "emake test failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" LIBDIR="$(get_libdir)" install
	use static-libs || rm -f "${ED}"/usr/$(get_libdir)/*.{a,la}
}
