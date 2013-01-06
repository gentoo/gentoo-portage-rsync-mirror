# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Pod-Abstract/Pod-Abstract-0.200.0.ebuild,v 1.1 2011/08/29 10:38:30 tove Exp $

EAPI=4

MODULE_AUTHOR=BLILBURNE
MODULE_VERSION=0.20
inherit perl-module

DESCRIPTION="Abstract document tree for Perl POD documents"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/IO-String
	virtual/perl-Scalar-List-Utils
	virtual/perl-File-Temp
"
DEPEND="${RDEPEND}
	test? (
		virtual/perl-Test-Simple
	)
"

SRC_TEST=do
