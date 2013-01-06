# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Role-Tiny/Role-Tiny-1.2.4.ebuild,v 1.1 2012/11/03 19:20:07 tove Exp $

EAPI=4

MODULE_AUTHOR=ILMARI
MODULE_VERSION=1.002004
inherit perl-module

DESCRIPTION="Roles. Like a nouvelle cuisine portion size slice of Moose"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc-macos ~x86-solaris"
IUSE="test"

DEPEND="
	test? (
		>=dev-perl/Test-Fatal-0.003
		>=virtual/perl-Test-Simple-0.96
		dev-perl/Class-Method-Modifiers
	)
"
RDEPEND="
	!<dev-perl/Moo-0.9.14
"

SRC_TEST="do"
