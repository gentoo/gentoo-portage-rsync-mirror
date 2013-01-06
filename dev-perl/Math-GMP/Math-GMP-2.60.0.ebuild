# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-GMP/Math-GMP-2.60.0.ebuild,v 1.7 2012/03/25 16:39:43 armin76 Exp $

EAPI=4

MODULE_AUTHOR=TURNSTEP
MODULE_VERSION=2.06
inherit perl-module

DESCRIPTION="High speed arbitrary size integer math"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="alpha amd64 hppa ~mips ppc x86"
IUSE=""

RDEPEND="dev-libs/gmp"
DEPEND="${RDEPEND}"

SRC_TEST=do
