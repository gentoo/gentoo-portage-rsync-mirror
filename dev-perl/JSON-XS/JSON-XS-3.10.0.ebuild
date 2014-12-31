# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/JSON-XS/JSON-XS-3.10.0.ebuild,v 1.3 2014/12/31 18:33:41 zlogene Exp $

EAPI=5

MODULE_AUTHOR=MLEHMANN
MODULE_VERSION=3.01
inherit perl-module

DESCRIPTION="JSON::XS - JSON serialising/deserialising, done correctly and fast"

SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x64-macos ~x86-solaris"
IUSE="test"

RDEPEND="
	dev-perl/Types-Serialiser
	dev-perl/common-sense
"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? ( virtual/perl-Test-Harness )"

SRC_TEST="do"
