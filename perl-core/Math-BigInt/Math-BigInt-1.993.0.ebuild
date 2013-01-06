# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Math-BigInt/Math-BigInt-1.993.0.ebuild,v 1.3 2011/06/24 14:31:54 grobian Exp $

EAPI=3

MODULE_AUTHOR=PJACKLAM
MODULE_VERSION=1.993
inherit perl-module eutils

DESCRIPTION="Arbitrary size floating point math package"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~s390 ~sh ~sparc ~x86 ~ppc-macos ~x86-solaris"
IUSE=""

RDEPEND=">=virtual/perl-Scalar-List-Utils-1.14"
DEPEND="${RDEPEND}"

PDEPEND=">=virtual/perl-Math-BigInt-FastCalc-0.25
	>=perl-core/bignum-0.22
	>=perl-core/Math-BigRat-0.260.200"

SRC_TEST="do"
