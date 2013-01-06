# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Deep/Test-Deep-0.110.0.ebuild,v 1.8 2012/10/02 00:19:14 blueness Exp $

EAPI=4

MODULE_AUTHOR=RJBS
MODULE_VERSION=0.110
inherit perl-module

DESCRIPTION="Test::Deep - Extremely flexible deep comparison"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="test"

DEPEND="
	test? ( dev-perl/Test-NoWarnings
		dev-perl/Test-Tester )"
RDEPEND=""

SRC_TEST="do"
