# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-AIO/IO-AIO-3.3.ebuild,v 1.1 2009/08/25 17:49:58 robbat2 Exp $

MODULE_AUTHOR="MLEHMANN"
inherit perl-module

DESCRIPTION="Asynchronous Input/Output"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"

mydoc="Changes README"
SRC_TEST="do"

DEPEND="dev-lang/perl
		dev-perl/common-sense"
RDEPEND="${DEPEND}"
