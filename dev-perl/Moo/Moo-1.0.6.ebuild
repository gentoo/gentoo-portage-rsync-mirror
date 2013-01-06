# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Moo/Moo-1.0.6.ebuild,v 1.1 2012/11/17 20:18:32 tove Exp $

EAPI=4

MODULE_AUTHOR=ILMARI
MODULE_VERSION=1.000006
inherit perl-module

DESCRIPTION="Minimalist Object Orientation (with Moose compatiblity)"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc-aix ~ppc-macos ~x86-solaris"
IUSE="test"

RDEPEND="
	>=dev-perl/Class-Method-Modifiers-1.100.0
	>=dev-perl/Devel-GlobalDestruction-0.90.0
	>=dev-perl/Module-Runtime-0.12.0
	>=dev-perl/Role-Tiny-1.2.4
	>=dev-perl/strictures-1.4.3
"
DEPEND="${RDEPEND}
	test? (
		>=dev-perl/Test-Fatal-0.3.0
		>=virtual/perl-Test-Simple-0.96
	)
"

SRC_TEST=do
