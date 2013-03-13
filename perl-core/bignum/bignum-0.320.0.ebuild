# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/bignum/bignum-0.320.0.ebuild,v 1.1 2013/03/13 07:59:16 tove Exp $

EAPI=5

MODULE_AUTHOR=FLORA
MODULE_VERSION=0.32
inherit perl-module

DESCRIPTION="Transparent BigNumber/BigRational support for Perl"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~s390 ~sh ~sparc ~x86 ~ppc-aix ~ppc-macos ~x86-solaris"
IUSE=""

RDEPEND="
	>=perl-core/Math-BigInt-1.880.0
	>=perl-core/Math-BigRat-0.210.0
"
DEPEND="${RDEPEND}"
#	test? (
#		dev-perl/Test-Pod
#		>=dev-perl/Test-Pod-Coverage-1.08
#	)
#"

SRC_TEST="do"
