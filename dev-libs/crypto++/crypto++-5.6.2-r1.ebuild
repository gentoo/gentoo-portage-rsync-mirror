# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/crypto++/crypto++-5.6.2-r1.ebuild,v 1.10 2014/03/19 13:52:25 ago Exp $

EAPI=5

inherit eutils flag-o-matic multilib toolchain-funcs autotools

DESCRIPTION="C++ class library of cryptographic schemes"
HOMEPAGE="http://cryptopp.com"
SRC_URI="mirror://sourceforge/cryptopp/cryptopp${PV//.}.zip"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ppc ppc64 sparc x86 ~x64-macos"
IUSE="static-libs"

DEPEND="app-arch/unzip
	sys-devel/libtool"

S=${WORKDIR}

src_prepare() {
	epatch "${FILESDIR}"/${P}-r1-make.patch

	# Generate our own libtool script for building.
	cat <<-EOF > configure.ac
	AC_INIT(lt, 0)
	AM_INIT_AUTOMAKE
	AC_PROG_CXX
	LT_INIT
	AC_CONFIG_FILES(Makefile)
	AC_OUTPUT
	EOF
	touch NEWS README AUTHORS ChangeLog Makefile.am
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_compile() {
	# higher optimizations cause problems
	replace-flags -O? -O1
	filter-flags -fomit-frame-pointer
	# ASM isn't Darwin/Mach-O ready, #479554, buildsys doesn't grok CPPFLAGS
	[[ ${CHOST} == *-darwin* ]] && append-flags -DCRYPTOPP_DISABLE_X86ASM

	emake -f GNUmakefile CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}" LIBDIR="$(get_libdir)" PREFIX="${EPREFIX}/usr" LIBTOOL="./libtool"
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
	emake DESTDIR="${D}" LIBDIR="$(get_libdir)" PREFIX="${EPREFIX}/usr" LIBTOOL="./libtool" install
	use static-libs || rm -f "${ED}"/usr/$(get_libdir)/*.la
}
