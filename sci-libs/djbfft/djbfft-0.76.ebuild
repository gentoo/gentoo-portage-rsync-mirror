# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/djbfft/djbfft-0.76.ebuild,v 1.10 2008/04/06 17:45:23 hollow Exp $

inherit eutils flag-o-matic toolchain-funcs multilib

DESCRIPTION="extremely fast library for floating-point convolution"
HOMEPAGE="http://cr.yp.to/djbfft.html"
SRC_URI="http://cr.yp.to/djbfft/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

# the "check" target of the Makefile (version 0.76 at least) only checks if
# all files were installed with correct permissions. Can't check that at
# this point of the installation.
RESTRICT="test"

src_unpack() {
	MY_PV="${PV:0:1}.${PV:2:1}.${PV:3:1}" # a.bc -> a.b.c
	MY_D="${D}usr"

	# mask out everything, which is not suggested by the author (RTFM)!
	ALLOWED_FLAGS="-fstack-protector -march -mcpu -pipe -mpreferred-stack-boundary -ffast-math"
	strip-flags

	MY_CFLAGS="${CFLAGS} -O1 -fomit-frame-pointer"
	use x86 && MY_CFLAGS="${MY_CFLAGS} -malign-double"

	LIBPERMS="0755"
	LIBDJBFFT="libdjbfft.so.${MY_PV}"

	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gcc3.patch"
	epatch "${FILESDIR}/${P}-shared.patch"

	sed -i -e "s:\"lib\":\"$(get_libdir)\":" hier.c
	echo "$(tc-getCC) $MY_CFLAGS -fPIC -DPIC" > "conf-cc"
	echo "$(tc-getCC) ${LDFLAGS}" > "conf-ld"
	echo "${MY_D}" > "conf-home"
	einfo "conf-cc: $(<conf-cc)"
}

src_compile() {
	emake LIBDJBFFT="$LIBDJBFFT" LIBPERMS="$LIBPERMS" || die "emake failed"
}

src_install() {
	make LIBDJBFFT="$LIBDJBFFT" setup check || die "install  failed"
	dosym "${LIBDJBFFT}" /usr/$(get_libdir)/libdjbfft.so
	dosym "${LIBDJBFFT}" /usr/$(get_libdir)/libdjbfft.so.${MY_PV%%.*}
	dodoc CHANGES README TODO VERSION
}
