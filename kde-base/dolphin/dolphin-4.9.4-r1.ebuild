# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dolphin/dolphin-4.9.4-r1.ebuild,v 1.1 2012/12/08 00:31:34 creffett Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kde-baseapps"
inherit kde4-meta

DESCRIPTION="A KDE filemanager focusing on usability"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
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

PATCHES=( "${FILESDIR}/${PN}-4.9.4-drag-and-drop-and-keyboard-focus.patch" )

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
