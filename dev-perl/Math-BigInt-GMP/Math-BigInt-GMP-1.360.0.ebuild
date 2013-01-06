# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-BigInt-GMP/Math-BigInt-GMP-1.360.0.ebuild,v 1.1 2011/02/26 19:08:50 tove Exp $

EAPI=3

MODULE_AUTHOR=PJACKLAM
MODULE_VERSION=1.36
inherit perl-module

DESCRIPTION="Use the GMP library for Math::BigInt routines"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=virtual/perl-Math-BigInt-1.993.0
		 >=dev-libs/gmp-4.0.0"
DEPEND="${RDEPEND}"

SRC_TEST="do"
