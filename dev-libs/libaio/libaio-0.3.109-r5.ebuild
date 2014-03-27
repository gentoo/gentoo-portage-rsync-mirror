# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libaio/libaio-0.3.109-r5.ebuild,v 1.1 2014/03/27 02:09:25 vapier Exp $

EAPI=5

inherit eutils multilib-minimal toolchain-funcs

DESCRIPTION="Asynchronous input/output library that uses the kernels native interface"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/andrea/libaio/ http://lse.sourceforge.net/io/aio.html"
SRC_URI="mirror://kernel/linux/libs/aio/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="static-libs test"

src_prepare() {
	# remove stuff provided by man-pages now
	rm man/{lio_listio,aio_{cancel,error,fsync,init,read,return,suspend,write}}.* || die

	epatch \
		"${FILESDIR}"/${PN}-0.3.109-unify-bits-endian.patch \
		"${FILESDIR}"/${PN}-0.3.109-generic-arch.patch \
		"${FILESDIR}"/${PN}-0.3.106-build.patch \
		"${FILESDIR}"/${PN}-0.3.107-ar-ranlib.patch \
		"${FILESDIR}"/${PN}-0.3.109-install.patch \
		"${FILESDIR}"/${PN}-0.3.109-x32.patch \
		"${FILESDIR}"/${PN}-0.3.109-testcase-8.patch

	local sed_args=(
		-e "/^prefix=/s:/usr:${EPREFIX}/usr:"
		-e '/^libdir=/s:lib$:$(ABI_LIBDIR):'
		-e '/:=.*strip.*shell.*git/s:=.*:=:'
	)
	if ! use static-libs; then
		sed_args+=( -e '/\tinstall .*\/libaio.a/d' )
		# Tests require the static library to be built.
		use test || sed_args+=( -e '/^all_targets +=/s/ libaio.a//' )
	fi
	sed -i "${sed_args[@]}" src/Makefile Makefile || die
	sed -i -e "s:-Werror::g" harness/Makefile || die

	multilib_copy_sources
}

_emake() {
	CC=$(tc-getCC) \
	AR=$(tc-getAR) \
	RANLIB=$(tc-getRANLIB) \
	ABI_LIBDIR=$(get_libdir) \
	emake "$@"
}

multilib_src_compile() {
	_emake
}

multilib_src_test() {
	mkdir -p testdir || die
	# 'make check' breaks with sandbox, 'make partcheck' works
	_emake partcheck prefix="${S}/src" libdir="${S}/src"
}

multilib_src_install() {
	_emake install DESTDIR="${D}"
}

multilib_src_install_all() {
	doman man/*
	dodoc ChangeLog TODO

	# move crap to / for multipath-tools #325355
	gen_usr_ldscript -a aio
}
