# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-whiskermenu-plugin/xfce4-whiskermenu-plugin-1.0.3.ebuild,v 1.1 2013/07/18 12:56:08 hasufell Exp $

EAPI=5

inherit eutils gnome2-utils cmake-utils

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
	# merged upstream
	# https://github.com/gottcode/xfce4-whiskermenu-plugin/pull/18
	epatch "${FILESDIR}"/${P}-{Werror,ldflags,reorder-flags}.patch

	local i
	if [[ -n "${LINGUAS+x}" ]] ; then
		for i in $(grep add_subdirectory po/CMakeLists.txt | sed 's/add_subdirectory(//;s/)$//') ; do
			has ${i} ${LINGUAS} || { sed -i -e "/add_subdirectory(${i})/d" po/CMakeLists.txt || die ; }
		done
	fi
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_WERROR=OFF
		-DENABLE_AS_NEEDED=OFF
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
