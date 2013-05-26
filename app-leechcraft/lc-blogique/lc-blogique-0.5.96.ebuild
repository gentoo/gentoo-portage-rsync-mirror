# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-blogique/lc-blogique-0.5.96.ebuild,v 1.1 2013/05/26 19:36:32 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Blogging client for LeechCraft"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +metida +hestia"

DEPEND="~app-leechcraft/lc-core-${PV}
	dev-qt/qtsql:4[sqlite]
	metida? ( dev-qt/qtxmlpatterns:4 )
	"
RDEPEND="${DEPEND}
	virtual/leechcraft-wysiwyg-editor
	"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable metida BLOGIQUE_METIDA)
		$(cmake-utils_use_enable hestia BLOGIQUE_HESTIA)
	)

	cmake-utils_src_configure
}
