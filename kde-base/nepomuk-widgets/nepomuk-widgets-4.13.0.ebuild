# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/nepomuk-widgets/nepomuk-widgets-4.13.0.ebuild,v 1.2 2014/04/17 00:43:39 johu Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="Widget library for nepomuk"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep nepomuk-core)
	>=dev-libs/soprano-2.9.0
"
RDEPEND="${DEPEND}
	!<kde-base/nepomuk-core-4.9.80:4
"

# tests hangs
RESTRICT="test"
