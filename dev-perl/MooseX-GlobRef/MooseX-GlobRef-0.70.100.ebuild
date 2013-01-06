# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MooseX-GlobRef/MooseX-GlobRef-0.70.100.ebuild,v 1.1 2011/08/29 17:46:21 tove Exp $

EAPI=4

MODULE_AUTHOR=DEXTER
MODULE_VERSION=0.0701
inherit perl-module

DESCRIPTION="Store a Moose object in glob reference"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/Moose-0.96"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		>=dev-perl/Test-Unit-Lite-0.12
		dev-perl/Test-Assert
		virtual/perl-parent
	)"

SRC_TEST=do
