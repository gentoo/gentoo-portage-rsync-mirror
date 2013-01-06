# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Array-Window/Array-Window-1.20.0.ebuild,v 1.2 2011/09/03 21:05:03 tove Exp $

EAPI=4

MODULE_AUTHOR=ADAMK
MODULE_VERSION=1.02
inherit perl-module

DESCRIPTION="Array::Window - Calculate windows/subsets/pages of arrays"

SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
IUSE="test"

RDEPEND="dev-perl/Params-Util"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Simple )"

SRC_TEST="do"
