# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcalc/kcalc-4.9.5.ebuild,v 1.1 2013/01/05 20:18:36 creffett Exp $

EAPI=4

KDE_HANDBOOK="optional"
CPPUNIT_REQUIRED="optional"
inherit kde4-base

DESCRIPTION="KDE calculator"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	dev-libs/gmp
"
RDEPEND="${DEPEND}"

RESTRICT="test"
# bug 393093

src_test() {
	LANG=C kde4-base_src_test
}
