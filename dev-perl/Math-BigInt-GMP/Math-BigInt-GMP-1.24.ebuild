# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-BigInt-GMP/Math-BigInt-GMP-1.24.ebuild,v 1.8 2010/09/06 18:49:11 armin76 Exp $

MODULE_AUTHOR="TELS/math"
inherit perl-module

DESCRIPTION="Use the GMP library for Math::BigInt routines"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 hppa ppc sparc x86"
RDEPEND=">=perl-core/Math-BigInt-1.87
		 >=dev-libs/gmp-4.0.0"
DEPEND="${RDEPEND}"

SRC_TEST="do"
