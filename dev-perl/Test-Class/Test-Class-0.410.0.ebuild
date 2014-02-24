# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Class/Test-Class-0.410.0.ebuild,v 1.1 2014/02/24 17:56:09 zlogene Exp $

EAPI=5

MODULE_AUTHOR=RJBS
MODULE_VERSION=0.41
inherit perl-module

DESCRIPTION="Easily create test classes in an xUnit style."

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND=">=virtual/perl-Storable-2
	>=virtual/perl-Test-Simple-0.78
	dev-perl/MRO-Compat"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.380.0
	test? ( >=dev-perl/Test-Exception-0.25 )"

SRC_TEST="do"
