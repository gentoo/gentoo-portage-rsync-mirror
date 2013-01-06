# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Module-CoreList/Module-CoreList-2.38.ebuild,v 1.3 2010/11/05 12:07:17 fauli Exp $

EAPI=3

MODULE_AUTHOR=BINGOS
inherit perl-module

DESCRIPTION="what modules shipped with versions of perl"

SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

#RDEPEND=""
#DEPEND="test? ( dev-perl/Test-Pod )"

SRC_TEST=do
