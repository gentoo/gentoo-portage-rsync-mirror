# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Exception-Base/Exception-Base-0.240.100.ebuild,v 1.1 2011/01/14 12:08:13 tove Exp $

EAPI=3

MODULE_AUTHOR=DEXTER
MODULE_VERSION=0.2401
inherit perl-module

DESCRIPTION="Error handling with exception class"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( >=dev-perl/Test-Unit-Lite-0.12 )"

SRC_TEST=do
