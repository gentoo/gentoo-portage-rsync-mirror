# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/juk/juk-4.10.2.ebuild,v 1.5 2013/05/05 10:14:36 ago Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="Jukebox and music manager for KDE."
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	>=media-libs/taglib-1.6
"
RDEPEND="${DEPEND}"

src_configure() {
	# http://bugs.gentoo.org/410551 for disabling deprecated TunePimp support
	mycmakeargs=(
		-DWITH_TunePimp=OFF
	)

	kde4-base_src_configure
}
