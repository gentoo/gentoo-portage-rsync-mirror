# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Math-BigInt-FastCalc/Math-BigInt-FastCalc-0.300.0-r1.ebuild,v 1.1 2014/07/26 14:02:04 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=PJACKLAM
MODULE_VERSION=0.30
inherit perl-module

DESCRIPTION="Math::BigInt::Calc with some XS for more speed"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc s390 sh sparc x86 ~ppc-aix ~ppc-macos ~x86-solaris"
IUSE=""

RDEPEND=">=virtual/perl-Math-BigInt-1.997.0
	virtual/perl-XSLoader"
DEPEND="${RDEPEND}"

SRC_TEST="do"
