# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Chart-Math-Axis/Chart-Math-Axis-1.60.0.ebuild,v 1.5 2011/12/05 23:34:04 chainsaw Exp $

EAPI=3

MODULE_AUTHOR=ADAMK
MODULE_VERSION=1.06
inherit perl-module

DESCRIPTION="Implements an algorithm to find good values for chart axis"

SLOT="0"
KEYWORDS="amd64 hppa ~mips ~ppc x86"
IUSE=""

RDEPEND=">=virtual/perl-Math-BigInt-1.70
	>=virtual/perl-Storable-2.12
	>=dev-perl/Params-Util-0.15"
DEPEND="${RDEPEND}"

SRC_TEST="do"
