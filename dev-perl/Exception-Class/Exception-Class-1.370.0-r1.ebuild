# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Exception-Class/Exception-Class-1.370.0-r1.ebuild,v 1.1 2014/08/23 01:26:32 axs Exp $

EAPI=5

MODULE_AUTHOR=DROLSKY
MODULE_VERSION=1.37
inherit perl-module

DESCRIPTION="A module that allows you to declare real exception classes in Perl"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86 ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND="
	>=dev-perl/Class-Data-Inheritable-0.20.0
	>=dev-perl/Devel-StackTrace-1.200.0
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.310.0
"

SRC_TEST="do"
