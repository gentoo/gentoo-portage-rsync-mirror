# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Math-BigInt/Math-BigInt-1.89.ebuild,v 1.7 2010/01/05 19:03:39 nixnut Exp $

MODULE_AUTHOR=TELS
MODULE_SECTION=math
inherit perl-module eutils

DESCRIPTION="Arbitrary size floating point math package"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc s390 sh sparc x86"
IUSE=""

DEPEND="dev-lang/perl
		>=virtual/perl-Scalar-List-Utils-1.14"

PDEPEND=">=perl-core/bignum-0.22
		>=perl-core/Math-BigRat-0.22"

SRC_TEST="do"
PREFER_BUILDPL="no"
