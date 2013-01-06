# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/kmldonkey/kmldonkey-2.0.2-r2.ebuild,v 1.5 2011/10/28 20:58:13 abcd Exp $

EAPI=4

KDE_PV="4.4.0"
SLOT="4"
KDE_LINGUAS="ca cs el es et fr ga gl it nb nl pt ru sv tr uk zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="Provides integration for the MLDonkey P2P software and KDE 4."
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2 LGPL-2"
SRC_URI="mirror://kde/stable/Attic/${KDE_PV}/src/extragear/${P}-kde${KDE_PV}.tar.bz2"

KEYWORDS="~amd64 ~x86"
IUSE="debug plasma"

RDEPEND="plasma? ( $(add_kdebase_dep plasma-workspace) )"
DEPEND="${RDEPEND}
		sys-devel/gettext"

S=${WORKDIR}/${P}-kde${KDE_PV}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with plasma)
	)

	kde4-base_src_configure
}
