# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Compress-Raw-Bzip2/Compress-Raw-Bzip2-2.60.0.ebuild,v 1.14 2014/01/17 06:07:59 vapier Exp $

EAPI=5

MODULE_AUTHOR=PMQS
MODULE_VERSION=2.060
inherit perl-module

DESCRIPTION="Low-Level Interface to bzip2 compression library"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="app-arch/bzip2"
DEPEND="${RDEPEND}"
#	test? ( dev-perl/Test-Pod )"

SRC_TEST=parallel

src_prepare() {
	rm -rf "${S}"/bzip2-src/ || die
	sed -i '/^bzip2-src/d' "${S}"/MANIFEST || die
	perl-module_src_prepare
}

src_configure(){
	BUILD_BZIP2=0 BZIP2_INCLUDE=. BZIP2_LIB= \
		perl-module_src_configure
}
