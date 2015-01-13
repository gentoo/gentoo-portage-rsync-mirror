# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Validate-Domain/Data-Validate-Domain-0.100.0.ebuild,v 1.4 2015/01/13 06:58:26 zlogene Exp $

EAPI=5

MODULE_AUTHOR="NEELY"
MODULE_VERSION="0.10"

inherit perl-module

DESCRIPTION="Light weight module for validating domains"

SLOT="0"
KEYWORDS="amd64"
IUSE="test"

RDEPEND=">=dev-perl/Net-Domain-TLD-1.690.0"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Simple )
"

SRC_TEST=do
