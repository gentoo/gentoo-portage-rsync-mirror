# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-Vec/Math-Vec-1.10.0.ebuild,v 1.2 2011/09/03 21:04:42 tove Exp $

EAPI=4

MODULE_AUTHOR=EWILHELM
MODULE_VERSION=1.01
inherit perl-module

DESCRIPTION="Vectors for perl"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( virtual/perl-Test-Simple )"

SRC_TEST="do"
