# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-LexAlias/Devel-LexAlias-0.40.0.ebuild,v 1.3 2013/04/16 17:19:50 vincent Exp $

EAPI=4

MODULE_AUTHOR=RCLAMP
MODULE_VERSION=0.04
inherit perl-module

DESCRIPTION="Alias lexical variables"

SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE=""

DEPEND=">=dev-perl/Devel-Caller-2.03"
RDEPEND="${DEPEND}"
