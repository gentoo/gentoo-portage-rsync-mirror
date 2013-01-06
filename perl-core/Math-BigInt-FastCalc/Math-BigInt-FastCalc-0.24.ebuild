# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Math-BigInt-FastCalc/Math-BigInt-FastCalc-0.24.ebuild,v 1.5 2010/12/07 05:04:52 mattst88 Exp $

EAPI=3

MODULE_AUTHOR=FLORA
inherit perl-module

DESCRIPTION="Math::BigInt::Calc with some XS for more speed"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND=">=virtual/perl-Math-BigInt-1.97
	virtual/perl-XSLoader"
DEPEND="${RDEPEND}"

SRC_TEST="do"
