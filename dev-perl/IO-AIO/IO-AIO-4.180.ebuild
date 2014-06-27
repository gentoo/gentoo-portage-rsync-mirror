# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-AIO/IO-AIO-4.180.ebuild,v 1.2 2014/06/27 17:31:45 zlogene Exp $

EAPI=4

MODULE_AUTHOR=MLEHMANN
MODULE_VERSION=4.18
inherit perl-module

DESCRIPTION="Asynchronous Input/Output"

SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="dev-perl/common-sense"
RDEPEND="${DEPEND}"

SRC_TEST="do"
