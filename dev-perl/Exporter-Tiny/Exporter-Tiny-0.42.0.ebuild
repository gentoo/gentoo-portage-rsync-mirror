# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Exporter-Tiny/Exporter-Tiny-0.42.0.ebuild,v 1.1 2015/02/21 21:06:01 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=TOBYINK
MODULE_VERSION=0.042
inherit perl-module

DESCRIPTION="An exporter with the features of Sub::Exporter but only core dependencies"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.170.0
	test? (
		>=virtual/perl-Test-Simple-0.470.0
	)
"
