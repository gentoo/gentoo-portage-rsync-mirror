# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-BOM/File-BOM-0.140.0.ebuild,v 1.1 2011/08/31 10:10:45 tove Exp $

EAPI=4

MODULE_AUTHOR=MATTLAW
MODULE_VERSION=0.14
inherit perl-module

DESCRIPTION="Utilities for handling Byte Order Marks"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-solaris"
IUSE="test"

RDEPEND="dev-perl/Readonly"
DEPEND="virtual/perl-Module-Build
	test? (
		${RDEPEND}
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
		dev-perl/Test-Exception
	)"

SRC_TEST=do
