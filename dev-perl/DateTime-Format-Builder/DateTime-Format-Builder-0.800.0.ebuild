# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-Builder/DateTime-Format-Builder-0.800.0.ebuild,v 1.3 2012/09/01 11:30:43 grobian Exp $

EAPI=4

MODULE_AUTHOR=DROLSKY
MODULE_VERSION=0.80
inherit perl-module

DESCRIPTION="Create DateTime parser classes and objects"

SLOT="0"
KEYWORDS="amd64 x86 ~ppc-aix ~x86-solaris"
IUSE="test"

RDEPEND="dev-perl/DateTime
	dev-perl/Class-Factory-Util
	>=dev-perl/Params-Validate-0.91
	>=dev-perl/DateTime-Format-Strptime-1.0800"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Pod )"

SRC_TEST=do
