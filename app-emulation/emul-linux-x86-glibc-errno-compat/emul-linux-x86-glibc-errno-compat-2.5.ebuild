# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-glibc-errno-compat/emul-linux-x86-glibc-errno-compat-2.5.ebuild,v 1.3 2012/05/31 22:32:20 zmedico Exp $

inherit eutils flag-o-matic

PATCH_VER="1.8"

DESCRIPTION="standalone glibc for old x86 binaries that require errno compat"
HOMEPAGE="http://dev.gentoo.org/~vapier/old-broken-errno-apps"
SRC_URI="mirror://gnu/glibc/glibc-${PV}.tar.bz2
	mirror://gnu/glibc/glibc-linuxthreads-${PV}.tar.bz2
	mirror://gentoo/glibc-${PV}-patches-${PATCH_VER}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S=${WORKDIR}/glibc-${PV}

CRAZY_PREFIX="/usr/lib/glibc-errno-compat"

src_unpack() {
	unpack glibc-${PV}.tar.bz2
	cd "${S}"
	unpack glibc-linuxthreads-${PV}.tar.bz2
	unpack glibc-${PV}-patches-${PATCH_VER}.tar.bz2
	grep -l '^--- ports/' patches/*.patch | xargs rm -f
	EPATCH_SUFFIX="patch" epatch patches
	test-flags -fgnu89-inline && append-flags -fgnu89-inline
}

src_compile() {
	mkdir build || die
	cd build || die
	../configure \
		--prefix="${CRAZY_PREFIX}" \
		--build=${CBUILD} \
		--host=${CHOST} \
		--without-tls \
		--without-__thread \
		--disable-sanity-checks \
		--enable-add-ons=linuxthreads \
		|| die
	sed -i '/^defines/s:$: -U__i686 -U_FORTIFY_SOURCE:' config.make || die
	emake -j1 \
		PARALLELMFLAGS="${MAKEOPTS}" \
		build-programs="no" \
		lib \
		|| die
	emake -C ../linuxthreads objdir=${PWD} ${PWD}/linuxthreads/libpthread.so || die
}

src_install() {
	dobin "${FILESDIR}"/glibc-errno-wrapper || die
	dosed "s:@PREFIX@:${CRAZY_PREFIX}:g" /usr/bin/glibc-errno-wrapper || die

	cd build || die
	into "${CRAZY_PREFIX}"
	newlib.so elf/ld.so ld-linux.so.2 || die
	newlib.so libc.so libc.so.6 || die
	newlib.so linuxthreads/libpthread.so libpthread.so.0 || die
}
