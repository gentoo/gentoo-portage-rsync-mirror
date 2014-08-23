# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-Vec/Math-Vec-1.10.0-r1.ebuild,v 1.1 2014/08/23 21:59:57 axs Exp $

EAPI=5

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
