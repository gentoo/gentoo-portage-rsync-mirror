# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/AnyEvent-I3/AnyEvent-I3-0.150.0.ebuild,v 1.1 2013/02/20 18:33:08 tove Exp $

EAPI=5

MODULE_AUTHOR=MSTPLBG
MODULE_VERSION=0.15
inherit perl-module

DESCRIPTION="Communicate with the i3 window manager"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="
	dev-perl/AnyEvent
	dev-perl/JSON-XS
"
DEPEND="
	${COMMON_DEPEND}
"
RDEPEND="
	${COMMON_DEPEND}
"
#SRC_TEST="do"
