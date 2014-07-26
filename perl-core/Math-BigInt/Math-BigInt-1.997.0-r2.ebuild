# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Math-BigInt/Math-BigInt-1.997.0-r2.ebuild,v 1.1 2014/07/26 14:04:37 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=PJACKLAM
MODULE_VERSION=1.997
inherit perl-module eutils

DESCRIPTION="Arbitrary size floating point math package"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc s390 sh sparc x86 ~ppc-aix ~ppc-macos ~x86-solaris"
IUSE=""

RDEPEND=">=virtual/perl-Scalar-List-Utils-1.140.0"
DEPEND="${RDEPEND}"

PDEPEND=">=virtual/perl-Math-BigInt-FastCalc-0.270.0
	>=perl-core/bignum-0.220.0
	>=virtual/perl-Math-BigRat-0.260.200"

PATCHES=( "${FILESDIR}/${P}-overload.patch" )

SRC_TEST="do"
