# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Color-Library/Color-Library-0.21.0-r1.ebuild,v 1.1 2014/08/26 17:38:25 axs Exp $

EAPI=5

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
