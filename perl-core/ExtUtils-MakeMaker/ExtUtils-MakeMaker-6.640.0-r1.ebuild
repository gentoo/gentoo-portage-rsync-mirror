# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/ExtUtils-MakeMaker/ExtUtils-MakeMaker-6.640.0-r1.ebuild,v 1.1 2014/07/26 13:30:56 dilfridge Exp $

EAPI=5
MODULE_AUTHOR=MSCHWERN
MODULE_VERSION=6.64
inherit eutils perl-module

DESCRIPTION="Create a module Makefile"
HOMEPAGE="http://makemaker.org ${HOMEPAGE}"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND="
	>=virtual/perl-ExtUtils-Command-1.160.0
	>=virtual/perl-ExtUtils-Install-1.540.0
	>=virtual/perl-ExtUtils-Manifest-1.600.0
	>=virtual/perl-File-Spec-0.800.0
"
RDEPEND="${DEPEND}"
PDEPEND="
	>=virtual/perl-CPAN-Meta-2.112.621
	>=virtual/perl-Parse-CPAN-Meta-1.440.100
"

PATCHES=(
	"${FILESDIR}/6.62-delete_packlist_podlocal.patch"
	"${FILESDIR}/6.58-RUNPATH.patch"
)
SRC_TEST=do

src_prepare() {
	edos2unix "${S}/lib/ExtUtils/MM_Unix.pm"
	edos2unix "${S}/lib/ExtUtils/MM_Any.pm"

	perl-module_src_prepare
}

src_install() {
	perl-module_src_install

	# remove all the bundled distributions
	pushd "${D}" >/dev/null
	find ".${VENDOR_LIB}" -mindepth 1 -maxdepth 1 -not -name "ExtUtils" -exec rm -rf {} \+
	popd >/dev/null
}
