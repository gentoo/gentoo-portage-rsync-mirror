# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-LexAlias/Devel-LexAlias-0.40.0.ebuild,v 1.1 2011/08/31 12:24:07 tove Exp $

EAPI=4

MODULE_AUTHOR=RCLAMP
MODULE_VERSION=0.04
inherit perl-module

DESCRIPTION="Alias lexical variables"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-perl/Devel-Caller-2.03"
RDEPEND="${DEPEND}"
