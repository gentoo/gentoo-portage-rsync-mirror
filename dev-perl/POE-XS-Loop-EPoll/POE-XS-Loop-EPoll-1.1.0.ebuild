# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/POE-XS-Loop-EPoll/POE-XS-Loop-EPoll-1.1.0.ebuild,v 1.1 2011/08/29 11:02:07 tove Exp $

EAPI=4

MODULE_AUTHOR=TONYC
MODULE_VERSION=1.001
inherit perl-module

DESCRIPTION="An XS implementation of POE::Loop, using Linux epoll(2)."

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-perl/POE-1.287
	>=dev-perl/POE-Test-Loops-1.033"
RDEPEND="${DEPEND}"

SRC_TEST="do"
