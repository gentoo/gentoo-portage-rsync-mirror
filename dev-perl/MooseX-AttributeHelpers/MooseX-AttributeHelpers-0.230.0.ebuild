# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MooseX-AttributeHelpers/MooseX-AttributeHelpers-0.230.0.ebuild,v 1.2 2014/10/10 17:48:16 zlogene Exp $

EAPI=5

MODULE_AUTHOR=DROLSKY
MODULE_VERSION=0.23
inherit perl-module

DESCRIPTION="Extend your attribute interfaces"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/Moose-0.56"
DEPEND="${RDEPEND}
	test? (
		>=dev-perl/Test-Exception-0.21
		>=virtual/perl-Test-Simple-0.62
	)"

SRC_TEST="do"
