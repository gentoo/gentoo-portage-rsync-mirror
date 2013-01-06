# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dolphin/dolphin-4.9.3.ebuild,v 1.4 2012/11/30 15:17:44 ago Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kde-baseapps"
inherit kde4-meta

DESCRIPTION="A KDE filemanager focusing on usability"
KEYWORDS="amd64 ~arm ppc x86 ~amd64-linux ~x86-linux"
IUSE="debug semantic-desktop thumbnail"

DEPEND="
	$(add_kdebase_dep kdelibs 'semantic-desktop=')
	$(add_kdebase_dep libkonq)
	semantic-desktop? ( >=dev-libs/shared-desktop-ontologies-0.10.0 )
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kfind)
"
PDEPEND="
	thumbnail? (
		$(add_kdebase_dep thumbnailers)
		|| (
			$(add_kdebase_dep ffmpegthumbs)
			$(add_kdebase_dep mplayerthumbs)
		)
	)
"

KMLOADLIBS="libkonq"

RESTRICT="test"
# bug 393129

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with semantic-desktop Nepomuk)
	)

	kde4-meta_src_configure
}

pkg_postinst() {
	kde4-base_pkg_postinst
	echo
	elog "For .exe file preview support, install media-gfx/icoutils."
	echo
}
