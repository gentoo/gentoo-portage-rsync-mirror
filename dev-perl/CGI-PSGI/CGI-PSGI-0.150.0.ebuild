# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CGI-PSGI/CGI-PSGI-0.150.0.ebuild,v 1.1 2012/02/03 16:48:29 tove Exp $

EAPI="4"

MODULE_AUTHOR=MIYAGAWA
MODULE_VERSION=0.15
inherit perl-module

DESCRIPTION="Adapt CGI.pm to the PSGI protocol"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	>=virtual/perl-CGI-3.330.0
"
DEPEND="${RDEPEND}
	test? (
		>=virtual/perl-Test-Simple-0.88
	)
"

SRC_TEST="do"
