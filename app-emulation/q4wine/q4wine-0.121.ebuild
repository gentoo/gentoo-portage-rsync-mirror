# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/q4wine/q4wine-0.121.ebuild,v 1.3 2012/01/15 15:16:06 phajdan.jr Exp $

EAPI="2"
inherit cmake-utils

DESCRIPTION="Qt4 GUI configuration tool for Wine"
HOMEPAGE="http://q4wine.brezblock.org.ua/"
SRC_URI="mirror://sourceforge/${PN}/${PF}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug +icoutils +wineappdb -dbus gnome kde"

DEPEND="x11-libs/qt-gui:4
	x11-libs/qt-sql:4[sqlite]
	dev-util/cmake"

RDEPEND="x11-libs/qt-gui:4
	x11-libs/qt-sql:4[sqlite]
	app-admin/sudo
	app-emulation/wine
	>=sys-apps/which-2.19
	icoutils? ( >=media-gfx/icoutils-0.26.0 )
	sys-fs/fuseiso
	kde? ( kde-base/kdesu )
	gnome? ( x11-libs/gksu )
	dbus? ( x11-libs/qt-dbus:4 )"

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
