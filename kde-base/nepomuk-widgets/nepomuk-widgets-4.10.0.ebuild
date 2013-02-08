# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/nepomuk-widgets/nepomuk-widgets-4.10.0.ebuild,v 1.2 2013/02/08 12:25:47 ago Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="Widget library for nepomuk"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep nepomuk-core)
	>=dev-libs/soprano-2.9.0
"
RDEPEND="${DEPEND}"

add_blocker nepomuk-core '<4.9.80'

# tests hangs
RESTRICT="test"
