# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Trap/Test-Trap-0.2.3.ebuild,v 1.2 2014/01/30 23:14:28 maekke Exp $

EAPI=5

MODULE_AUTHOR=EBHANSSEN
MODULE_VERSION=v${PV}

inherit perl-module

DESCRIPTION="Trap exit codes, exceptions, output, etc"

SLOT="0"
KEYWORDS=" ~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

# Carp??
RDEPEND="
	dev-perl/Data-Dump
	virtual/perl-Exporter
	virtual/perl-File-Temp
	virtual/perl-IO
"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.30
	test? (
		>=dev-perl/Test-Tester-0.107
	)"

SRC_TEST="do parallel"
