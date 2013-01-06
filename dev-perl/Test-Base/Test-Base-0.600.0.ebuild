# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Base/Test-Base-0.600.0.ebuild,v 1.7 2012/02/03 15:16:49 ranger Exp $

EAPI=4

MODULE_AUTHOR=INGY
MODULE_VERSION=0.60
inherit perl-module

DESCRIPTION="A Data Driven Testing Framework"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND=">=virtual/perl-Test-Simple-0.62
	>=dev-perl/Spiffy-0.30
	dev-perl/Test-Deep"
RDEPEND="${DEPEND}"

SRC_TEST="do"
