# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Number-Delta/Test-Number-Delta-1.30.0-r1.ebuild,v 1.1 2014/08/23 22:09:16 axs Exp $

EAPI=5

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
