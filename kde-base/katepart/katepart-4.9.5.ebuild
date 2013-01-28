# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/katepart/katepart-4.9.5.ebuild,v 1.4 2013/01/27 23:05:55 ago Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kate"
KMMODULE="part"
inherit kde4-meta

DESCRIPTION="KDE Editor KPart"
KEYWORDS="amd64 ~arm ppc x86 ~amd64-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

RESTRICT="test"
# bug 392993

add_blocker kdelibs 4.6.50

src_configure() {
	local mycmakeargs=(
		"-DKDE4_BUILD_TESTS=OFF"
	)

	kde4-meta_src_configure
}
