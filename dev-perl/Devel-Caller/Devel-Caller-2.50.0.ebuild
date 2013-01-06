# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Caller/Devel-Caller-2.50.0.ebuild,v 1.1 2011/08/31 12:27:48 tove Exp $

EAPI=4

MODULE_AUTHOR=RCLAMP
MODULE_VERSION=2.05
inherit perl-module

DESCRIPTION="Meatier versions of caller"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/PadWalker"
RDEPEND="${DEPEND}"

SRC_TEST=do
