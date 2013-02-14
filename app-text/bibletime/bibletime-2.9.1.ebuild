# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bibletime/bibletime-2.9.1.ebuild,v 1.6 2013/02/14 21:55:47 creffett Exp $

EAPI=5
inherit cmake-utils

DESCRIPTION="Qt4 Bible study application using the SWORD library."
HOMEPAGE="http://www.bibletime.info/"
SRC_URI="mirror://sourceforge/project/bibletime/BibleTime%202/BibleTime%202%20source%20code/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="debug"

# bug 313657
# RESTRICT="test"

RDEPEND="
	>=app-text/sword-1.6.0
	>=dev-cpp/clucene-2.3.3.4
	x11-libs/qt-core:4
	x11-libs/qt-dbus:4
	x11-libs/qt-gui:4
	x11-libs/qt-webkit:4"
DEPEND="
	${RDEPEND}
	dev-libs/boost
	dev-libs/icu:=
	net-misc/curl
	sys-libs/zlib
	x11-libs/qt-test:4"

DOCS=( ChangeLog README )

src_prepare() {
	sed -e "s:Dictionary;Qt:Dictionary;Office;TextTools;Utility;Qt;:" \
	    -i cmake/platforms/linux/bibletime.desktop.cmake || die "fixing .desktop file failed"
}

src_configure() {
	local mycmakeargs=(
		-DUSE_QT_WEBKIT=ON
	)

	cmake-utils_src_configure
}
