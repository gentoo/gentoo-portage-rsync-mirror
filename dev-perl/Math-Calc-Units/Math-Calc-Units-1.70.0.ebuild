# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-Calc-Units/Math-Calc-Units-1.70.0.ebuild,v 1.5 2012/12/06 04:13:56 phajdan.jr Exp $

EAPI=4

MODULE_AUTHOR=SFINK
MODULE_VERSION=1.07
inherit perl-module

DESCRIPTION="Human-readable unit-aware calculator"

SLOT="0"
KEYWORDS="amd64 hppa x86"
IUSE=""

DEPEND="virtual/perl-Time-Local"
RDEPEND="${DEPEND}"

SRC_TEST=do
