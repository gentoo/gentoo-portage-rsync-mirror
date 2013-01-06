# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Color-Library/Color-Library-0.21.0.ebuild,v 1.2 2012/06/07 12:16:38 tove Exp $

EAPI=4

MODULE_AUTHOR=ROKR
MODULE_VERSION=0.021
inherit perl-module

DESCRIPTION="An easy-to-use and comprehensive named-color library"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	virtual/perl-Module-Pluggable
	dev-perl/Class-Accessor
	dev-perl/Class-Data-Inheritable
"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Most
	)
"

SRC_TEST="do"
