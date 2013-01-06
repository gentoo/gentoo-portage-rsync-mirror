# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-blogique/leechcraft-blogique-9999.ebuild,v 1.1 2012/12/22 15:47:39 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Blogging client for LeechCraft"

SLOT="0"
KEYWORDS=""
IUSE="debug +metida"

DEPEND="~net-misc/leechcraft-core-${PV}
	x11-libs/qt-sql[sqlite]
	metida? ( x11-libs/qt-xmlpatterns )
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
