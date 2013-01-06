# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Math-BigInt-FastCalc/Math-BigInt-FastCalc-0.270.0.ebuild,v 1.2 2011/06/24 14:43:28 grobian Exp $

EAPI=3

MODULE_AUTHOR=PJACKLAM
MODULE_VERSION=0.27
inherit perl-module

DESCRIPTION="Math::BigInt::Calc with some XS for more speed"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~s390 ~sh ~sparc ~x86 ~ppc-macos"
IUSE=""

RDEPEND=">=virtual/perl-Math-BigInt-1.993
	virtual/perl-XSLoader"
DEPEND="${RDEPEND}"

SRC_TEST="do"
