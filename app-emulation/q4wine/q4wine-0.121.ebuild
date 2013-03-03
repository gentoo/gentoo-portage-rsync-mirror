# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/q4wine/q4wine-0.121.ebuild,v 1.4 2013/03/02 19:25:09 hwoarang Exp $

EAPI="2"
inherit cmake-utils

DESCRIPTION="Qt4 GUI configuration tool for Wine"
HOMEPAGE="http://q4wine.brezblock.org.ua/"
SRC_URI="mirror://sourceforge/${PN}/${PF}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug +icoutils +wineappdb -dbus gnome kde"

DEPEND="dev-qt/qtgui:4
	dev-qt/qtsql:4[sqlite]
	dev-util/cmake"

RDEPEND="dev-qt/qtgui:4
	dev-qt/qtsql:4[sqlite]
	app-admin/sudo
	app-emulation/wine
	>=sys-apps/which-2.19
	icoutils? ( >=media-gfx/icoutils-0.26.0 )
	sys-fs/fuseiso
	kde? ( kde-base/kdesu )
	gnome? ( x11-libs/gksu )
	dbus? ( dev-qt/qtdbus:4 )"

DOCS="README AUTHORS ChangeLog"

S="${WORKDIR}/${PF}"

src_configure() {
	mycmakeargs="${mycmakeargs} \
		$(cmake-utils_use debug DEBUG) \
		$(cmake-utils_use_with icoutils ICOUTILS) \
		$(cmake-utils_use_with wineappdb WINEAPPDB) \
		$(cmake-utils_use_with dbus DBUS)"

	cmake-utils_src_configure
}
