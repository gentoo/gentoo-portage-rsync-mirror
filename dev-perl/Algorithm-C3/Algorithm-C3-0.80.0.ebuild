# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Algorithm-C3/Algorithm-C3-0.80.0.ebuild,v 1.1 2011/08/27 16:20:17 tove Exp $

EAPI=4

MODULE_AUTHOR=FLORA
MODULE_VERSION=0.08
inherit perl-module

DESCRIPTION="A module for merging hierarchies using the C3 algorithm"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
