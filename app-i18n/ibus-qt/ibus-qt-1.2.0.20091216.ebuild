# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-qt/ibus-qt-1.2.0.20091216.ebuild,v 1.2 2012/05/03 19:24:31 jdhore Exp $

EAPI="1"
inherit cmake-utils multilib

MY_P="${P}-Source"
DESCRIPTION="Qt IBus library and Qt input method plugin"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-i18n/ibus-1.2
	>=sys-apps/dbus-1.2
	x11-libs/libX11
	>=x11-libs/qt-core-4.5:4
	>=x11-libs/qt-dbus-4.5:4"
DEPEND="${RDEPEND}
	app-doc/doxygen
	>=dev-libs/icu-4
	dev-util/cmake
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

DOCS="AUTHORS README TODO"

mycmakeargs="-DLIBDIR=$(get_libdir)"
