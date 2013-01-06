# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/bignum/bignum-0.280.0.ebuild,v 1.1 2011/07/12 15:55:42 tove Exp $

EAPI=4

MODULE_AUTHOR=FLORA
MODULE_VERSION=0.28
inherit perl-module

DESCRIPTION="Transparent BigNumber/BigRational support for Perl"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~s390 ~sh ~sparc ~x86 ~ppc-macos ~x86-solaris"
IUSE="test"

RDEPEND=">=perl-core/Math-BigInt-1.88
	>=perl-core/Math-BigRat-0.21"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
		>=dev-perl/Test-Pod-Coverage-1.08
	)
"

SRC_TEST="do"
