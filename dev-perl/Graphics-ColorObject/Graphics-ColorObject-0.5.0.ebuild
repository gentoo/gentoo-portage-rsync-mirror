# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Graphics-ColorObject/Graphics-ColorObject-0.5.0.ebuild,v 1.2 2012/11/30 06:17:12 bicatali Exp $
EAPI=2
MODULE_AUTHOR=AIZVORSKI
inherit perl-module

DESCRIPTION="convert between color spaces"
LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""
COMMON_DEPEND="
	>=dev-perl/Graphics-ColorNames-0.32
"
DEPEND="
	${COMMON_DEPEND}
"
RDEPEND="
	${COMMON_DEPEND}
"
SRC_TEST="do"
