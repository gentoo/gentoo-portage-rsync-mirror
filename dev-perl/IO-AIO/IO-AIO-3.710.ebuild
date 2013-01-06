# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-AIO/IO-AIO-3.710.ebuild,v 1.2 2011/02/07 18:38:53 robbat2 Exp $

EAPI=3

MODULE_AUTHOR="MLEHMANN"
MODULE_VERSION=3.71
inherit perl-module

DESCRIPTION="Asynchronous Input/Output"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-perl/common-sense"
RDEPEND="${DEPEND}"

SRC_TEST="do"
