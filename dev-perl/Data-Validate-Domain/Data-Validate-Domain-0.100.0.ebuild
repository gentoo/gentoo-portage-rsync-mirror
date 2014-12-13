# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Validate-Domain/Data-Validate-Domain-0.100.0.ebuild,v 1.3 2014/12/12 23:12:05 dilfridge Exp $

EAPI=5

MODULE_AUTHOR="NEELY"
MODULE_VERSION="0.10"

inherit perl-module

DESCRIPTION="Light weight module for validating domains"

SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND=">=dev-perl/Net-Domain-TLD-1.690.0"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Simple )
"

SRC_TEST=do
