# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/locale-maketext-lexicon/locale-maketext-lexicon-0.960.0-r1.ebuild,v 1.1 2014/08/23 00:15:20 axs Exp $

EAPI=5

MY_PN=Locale-Maketext-Lexicon
MODULE_AUTHOR=DRTECH
MODULE_VERSION=0.96
inherit perl-module

DESCRIPTION="Use other catalog formats in Maketext"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~ppc sparc x86 ~amd64-fbsd"
IUSE="test"

RDEPEND="
	>=virtual/perl-Locale-Maketext-1.170.0
"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
	)
"

SRC_TEST="do"
