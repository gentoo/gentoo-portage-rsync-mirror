# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-TCP/Test-TCP-1.180.0.ebuild,v 1.4 2012/12/17 18:31:01 ago Exp $

EAPI=4

MODULE_AUTHOR=TOKUHIROM
MODULE_VERSION=1.18
inherit perl-module

DESCRIPTION="Testing TCP program"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
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
