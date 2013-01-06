# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Variable-Magic/Variable-Magic-0.470.0.ebuild,v 1.4 2012/05/05 22:03:22 ranger Exp $

EAPI=4

MODULE_AUTHOR=VPIT
MODULE_VERSION=0.47
inherit perl-module

DESCRIPTION="Associate user-defined magic to variables from Perl"

SLOT="0"
KEYWORDS="amd64 ppc x86 ~x64-macos"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
