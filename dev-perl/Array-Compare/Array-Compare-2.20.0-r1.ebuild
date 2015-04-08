# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Array-Compare/Array-Compare-2.20.0-r1.ebuild,v 1.1 2014/08/24 01:48:06 axs Exp $

EAPI=5

MODULE_AUTHOR=DAVECROSS
MODULE_VERSION=2.02
inherit perl-module

DESCRIPTION="Perl extension for comparing arrays"

SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

SRC_TEST="do"

RDEPEND="dev-perl/Moose"
DEPEND=">=virtual/perl-Module-Build-0.28
	test? ( ${RDEPEND}
		dev-perl/Test-NoWarnings
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"
