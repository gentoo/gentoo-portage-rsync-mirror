# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Type-Tiny/Type-Tiny-1.0.5.ebuild,v 1.2 2015/03/29 10:00:48 jer Exp $

EAPI=5

MODULE_AUTHOR=TOBYINK
MODULE_VERSION=1.000005
inherit perl-module

DESCRIPTION="tiny, yet Moo(se)-compatible type constraint"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="test"

RDEPEND="
	>=dev-perl/Exporter-Tiny-0.26.0
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.170.0
	test? (
		>=virtual/perl-Test-Simple-0.960.0
	)
"
