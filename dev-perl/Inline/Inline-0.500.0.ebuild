# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Inline/Inline-0.500.0.ebuild,v 1.9 2013/01/06 20:19:05 tove Exp $

EAPI=4

MODULE_AUTHOR=SISYPHUS
MODULE_VERSION=0.50
inherit perl-module

DESCRIPTION="Write Perl subroutines in other languages"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc s390 sh sparc x86"
IUSE="test"

RDEPEND="virtual/perl-Digest-MD5
	virtual/perl-File-Spec
	dev-perl/Parse-RecDescent"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Warn
	)"

SRC_TEST=do

src_test() {
	MAKEOPTS+=" -j1" perl-module_src_test # bug 384137
}
