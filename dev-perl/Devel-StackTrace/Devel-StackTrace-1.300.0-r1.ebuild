# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-StackTrace/Devel-StackTrace-1.300.0-r1.ebuild,v 1.3 2014/11/11 11:48:12 blueness Exp $

EAPI=5

MODULE_AUTHOR=DROLSKY
MODULE_VERSION=1.30
inherit perl-module

DESCRIPTION="Devel-StackTrace module for perl"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ~ppc64 sparc x86 ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos"
IUSE="test"

RDEPEND="virtual/perl-File-Spec"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31
	test? ( >=virtual/perl-Test-Simple-0.88 )"

SRC_TEST="do"
