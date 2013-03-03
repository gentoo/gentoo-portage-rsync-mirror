# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-blogique/leechcraft-blogique-9999.ebuild,v 1.3 2013/03/02 23:01:57 hwoarang Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Blogging client for LeechCraft"

SLOT="0"
KEYWORDS=""
IUSE="debug +metida"

DEPEND="~net-misc/leechcraft-core-${PV}
	dev-qt/qtsql:4[sqlite]
	metida? ( dev-qt/qtxmlpatterns:4 )
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
