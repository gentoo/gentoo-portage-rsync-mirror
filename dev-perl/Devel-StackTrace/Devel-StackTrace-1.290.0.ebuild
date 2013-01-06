# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-StackTrace/Devel-StackTrace-1.290.0.ebuild,v 1.1 2012/11/17 20:07:24 tove Exp $

EAPI=4

MODULE_AUTHOR=DROLSKY
MODULE_VERSION=1.29
inherit perl-module

DESCRIPTION="Devel-StackTrace module for perl"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos"
IUSE="test"

RDEPEND="virtual/perl-File-Spec"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31
	test? ( >=virtual/perl-Test-Simple-0.88 )"

SRC_TEST="do"
