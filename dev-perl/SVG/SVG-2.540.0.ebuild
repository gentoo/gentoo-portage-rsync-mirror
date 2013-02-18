# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SVG/SVG-2.540.0.ebuild,v 1.1 2013/02/18 19:16:47 tove Exp $

EAPI=5

MODULE_AUTHOR=SZABGAB
MODULE_VERSION=2.54
inherit perl-module

DESCRIPTION="Perl extension for generating Scalable Vector Graphics (SVG) documents"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"

RDEPEND="virtual/perl-parent"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod-Coverage
	)
"

SRC_TEST=do
