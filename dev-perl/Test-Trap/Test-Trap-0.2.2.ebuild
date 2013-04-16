# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Trap/Test-Trap-0.2.2.ebuild,v 1.5 2013/04/16 17:19:51 vincent Exp $

EAPI=2

MODULE_AUTHOR=EBHANSSEN
MODULE_VERSION=v${PV}
inherit perl-module

DESCRIPTION="Trap exit codes, exceptions, output, etc"

SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="
	dev-perl/Data-Dump
"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.30
	test? (
		dev-perl/Test-Tester
	)
"

SRC_TEST="do parallel"
