# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Caller/Devel-Caller-2.60.0.ebuild,v 1.1 2013/01/19 19:47:36 tove Exp $

EAPI=5

MODULE_AUTHOR=RCLAMP
MODULE_VERSION=2.06
inherit perl-module

DESCRIPTION="Meatier versions of caller"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND="dev-perl/PadWalker"
RDEPEND="${DEPEND}"

SRC_TEST=do
