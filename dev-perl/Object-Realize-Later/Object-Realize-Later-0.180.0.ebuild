# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Object-Realize-Later/Object-Realize-Later-0.180.0.ebuild,v 1.3 2012/06/26 12:02:11 ago Exp $

EAPI=4

MODULE_AUTHOR=MARKOV
MODULE_VERSION=0.18
inherit perl-module

DESCRIPTION="Delay construction of real data until used"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND="
	virtual/perl-Scalar-List-Utils
"
DEPEND="${RDEPEND}
	test? (
		>=dev-perl/Test-Pod-1.0.0
	)
"

SRC_TEST=do
