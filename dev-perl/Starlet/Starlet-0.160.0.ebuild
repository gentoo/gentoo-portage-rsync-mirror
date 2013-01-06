# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Starlet/Starlet-0.160.0.ebuild,v 1.1 2012/09/13 18:53:19 tove Exp $

EAPI=4

MODULE_AUTHOR=KAZUHO
MODULE_VERSION=0.16
inherit perl-module

DESCRIPTION="A simple, high-performance PSGI/Plack HTTP server"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	>=dev-perl/Parallel-Prefork-0.130.0
	>=dev-perl/Plack-0.992.0
	>=dev-perl/Server-Starter-0.60.0
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.420.0
	test? (
		>=dev-perl/Test-TCP-0.150.0
		>=virtual/perl-Test-Simple-0.880.0
	)
"

SRC_TEST=do
