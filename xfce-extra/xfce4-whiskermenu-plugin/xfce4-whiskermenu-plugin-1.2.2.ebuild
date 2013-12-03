# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-whiskermenu-plugin/xfce4-whiskermenu-plugin-1.2.2.ebuild,v 1.1 2013/12/03 19:35:27 hasufell Exp $

EAPI=5

inherit gnome2-utils cmake-utils

DESCRIPTION="Alternate application launcher for Xfce"
HOMEPAGE="http://gottcode.org/xfce4-whiskermenu-plugin/"
SRC_URI="http://gottcode.org/xfce4-whiskermenu-plugin/${P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	x11-libs/gtk+:2
	xfce-base/exo
	xfce-base/garcon
	xfce-base/libxfce4ui
	xfce-base/libxfce4util
	xfce-base/xfce4-panel
	virtual/libintl"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext"

src_prepare() {
	local i
	if [[ -n "${LINGUAS+x}" ]] ; then
		for i in $(grep add_subdirectory po/CMakeLists.txt | sed 's/add_subdirectory(//;s/)$//') ; do
			has ${i} ${LINGUAS} || { sed -i -e "/add_subdirectory(${i})/d" po/CMakeLists.txt || die ; }
		done
	fi
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_AS_NEEDED=OFF
		-DENABLE_LINKER_OPTIMIZED_HASH_TABLES=OFF
		-DENABLE_DEVELOPER_MODE=OFF
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc ChangeLog CREDITS NEWS README
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
