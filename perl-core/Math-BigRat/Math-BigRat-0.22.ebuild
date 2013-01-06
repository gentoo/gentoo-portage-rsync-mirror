# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Math-BigRat/Math-BigRat-0.22.ebuild,v 1.7 2010/01/05 19:02:20 nixnut Exp $

MODULE_AUTHOR=TELS
MODULE_SECTION=math
inherit perl-module

DESCRIPTION="Arbitrary big rational numbers"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc s390 sh sparc x86"
IUSE=""

SRC_TEST="do"
PREFER_BUILDPL="no"

DEPEND=">=perl-core/Math-BigInt-1.88
	dev-lang/perl"
