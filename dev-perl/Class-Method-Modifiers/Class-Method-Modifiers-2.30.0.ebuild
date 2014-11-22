# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Method-Modifiers/Class-Method-Modifiers-2.30.0.ebuild,v 1.2 2014/11/22 19:59:07 zlogene Exp $

EAPI=5

MODULE_AUTHOR=ETHER
MODULE_VERSION=2.03
inherit perl-module

DESCRIPTION="provides Moose-like method modifiers"

SLOT="0"
KEYWORDS="amd64 x86 ~ppc-aix ~ppc-macos ~x86-solaris"
IUSE="test"

RDEPEND="
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.36
	test? (
		dev-perl/Test-Fatal
	)
"

SRC_TEST=do
