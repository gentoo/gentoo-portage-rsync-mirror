# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Number-Delta/Test-Number-Delta-1.30.0.ebuild,v 1.3 2011/10/29 18:04:49 tove Exp $

EAPI=4

MODULE_AUTHOR=DAGOLDEN
MODULE_VERSION=1.03
inherit perl-module versionator

DESCRIPTION="Compare the difference between numbers against a given tolerance"

SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
		virtual/perl-Module-Build"

SRC_TEST="do"
