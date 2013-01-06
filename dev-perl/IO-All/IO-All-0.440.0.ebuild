# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-All/IO-All-0.440.0.ebuild,v 1.1 2011/10/30 10:14:36 tove Exp $

EAPI=4

MODULE_AUTHOR=INGY
MODULE_VERSION=0.44
inherit perl-module

DESCRIPTION="unified IO operations"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/IO-String"
DEPEND="${RDEPEND}"

SRC_TEST=do
