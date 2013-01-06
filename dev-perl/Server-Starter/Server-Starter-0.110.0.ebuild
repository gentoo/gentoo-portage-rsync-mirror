# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Server-Starter/Server-Starter-0.110.0.ebuild,v 1.1 2012/02/02 18:40:59 tove Exp $

EAPI=4

MODULE_AUTHOR=KAZUHO
MODULE_VERSION=0.11
inherit perl-module

DESCRIPTION="A superdaemon for hot-deploying server programs"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	virtual/perl-Getopt-Long
	dev-perl/List-MoreUtils
	dev-perl/Proc-Wait3
	dev-perl/Scope-Guard
"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-SharedFork
		>=dev-perl/Test-TCP-0.110.0
	)
"

SRC_TEST="do"
