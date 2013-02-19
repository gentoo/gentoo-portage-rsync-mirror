# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Compress-Raw-Zlib/Compress-Raw-Zlib-2.60.0.ebuild,v 1.10 2013/02/19 21:46:02 ago Exp $

EAPI=5

MODULE_AUTHOR=PMQS
MODULE_VERSION=2.060
inherit multilib perl-module

DESCRIPTION="Low-Level Interface to zlib compression library"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ~ia64 ~m68k ~mips ppc ppc64 s390 ~sh ~sparc x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND=">=sys-libs/zlib-1.2.5"
DEPEND="${RDEPEND}"
#	test? ( dev-perl/Test-Pod )"

SRC_TEST=parallel

src_prepare() {
	rm -rf "${S}"/zlib-src/ || die
	sed -i '/^zlib-src/d' "${S}"/MANIFEST || die
	perl-module_src_prepare
}

src_configure() {
	BUILD_ZLIB=False \
	ZLIB_INCLUDE="${EPREFIX}"/usr/include \
	ZLIB_LIB="${EPREFIX}"/usr/$(get_libdir) \
		perl-module_src_configure
}
