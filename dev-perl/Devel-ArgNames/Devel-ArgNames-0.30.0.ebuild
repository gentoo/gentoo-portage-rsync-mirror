# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-ArgNames/Devel-ArgNames-0.30.0.ebuild,v 1.1 2011/08/31 12:28:22 tove Exp $

EAPI=4

MODULE_AUTHOR=NUFFIN
MODULE_VERSION=0.03
inherit perl-module

DESCRIPTION="Figure out the names of variables passed into subroutines"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/PadWalker"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-use-ok )"

SRC_TEST="do"
