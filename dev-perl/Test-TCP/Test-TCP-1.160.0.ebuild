# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-TCP/Test-TCP-1.160.0.ebuild,v 1.1 2012/07/03 17:46:57 tove Exp $

EAPI=4

MODULE_AUTHOR=TOKUHIROM
MODULE_VERSION=1.16
inherit perl-module

DESCRIPTION="Testing TCP program"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	>=dev-perl/Test-SharedFork-0.190.0
	>=virtual/perl-IO-1.23
"
DEPEND="${RDEPEND}
	test? (
		>=virtual/perl-Test-Simple-0.980.0
	)
"

SRC_TEST=do
