# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Size/Devel-Size-0.795.200.ebuild,v 1.1 2015/03/22 21:32:51 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=NWCLARK
MODULE_VERSION=0.79_52
inherit perl-module

DESCRIPTION="Perl extension for finding the memory usage of Perl variables"

SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="
	virtual/perl-XSLoader
"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? ( virtual/perl-Test-Simple )
"

SRC_TEST="do"
