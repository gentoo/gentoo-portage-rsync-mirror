# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/module-info/module-info-0.320.0.ebuild,v 1.8 2012/03/31 17:05:24 armin76 Exp $

EAPI=4

MY_PN=Module-Info
MODULE_AUTHOR=MBARBON
MODULE_VERSION=0.32
inherit perl-module

DESCRIPTION="Information about Perl modules"

SLOT="0"
KEYWORDS="alpha amd64 hppa ~mips ppc ppc64 x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
