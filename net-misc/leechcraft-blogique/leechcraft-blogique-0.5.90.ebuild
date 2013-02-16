# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-blogique/leechcraft-blogique-0.5.90.ebuild,v 1.4 2013/02/16 21:29:36 ago Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Blogging client for LeechCraft"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug +metida"

DEPEND="~net-misc/leechcraft-core-${PV}
	x11-libs/qt-sql:4[sqlite]
	metida? ( x11-libs/qt-xmlpatterns:4 )
	"
RDEPEND="${DEPEND}
	virtual/leechcraft-wysiwyg-editor
	"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable metida BLOGIQUE_METIDA)
	)

	cmake-utils_src_configure
}
