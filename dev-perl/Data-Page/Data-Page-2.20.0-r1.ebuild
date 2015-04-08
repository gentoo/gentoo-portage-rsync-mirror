# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Page/Data-Page-2.20.0-r1.ebuild,v 1.1 2014/08/26 18:18:46 axs Exp $

EAPI=5

MODULE_AUTHOR=LBROCARD
MODULE_VERSION=2.02
inherit perl-module

DESCRIPTION="help when paging through sets of results"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc-aix ~x86-solaris"
IUSE="test"

RDEPEND="dev-perl/Class-Accessor-Chained"
DEPEND="virtual/perl-Module-Build
	test? (
		${RDEPEND}
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
		dev-perl/Test-Exception
	)"

SRC_TEST=do
