# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Math-BigInt-FastCalc/Math-BigInt-FastCalc-0.290.0.ebuild,v 1.1 2011/07/12 15:59:33 tove Exp $

EAPI=4

MODULE_AUTHOR=FLORA
MODULE_VERSION=0.29
inherit perl-module

DESCRIPTION="Math::BigInt::Calc with some XS for more speed"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~s390 ~sh ~sparc ~x86 ~ppc-macos ~x86-solaris"
IUSE=""

RDEPEND=">=virtual/perl-Math-BigInt-1.993
	virtual/perl-XSLoader"
DEPEND="${RDEPEND}"

SRC_TEST="do"
