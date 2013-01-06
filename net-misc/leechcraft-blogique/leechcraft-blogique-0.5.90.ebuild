# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-blogique/leechcraft-blogique-0.5.90.ebuild,v 1.1 2012/12/25 16:42:49 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Blogging client for LeechCraft"

SLOT="0"
KEYWORDS="~amd64 ~x86"
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
