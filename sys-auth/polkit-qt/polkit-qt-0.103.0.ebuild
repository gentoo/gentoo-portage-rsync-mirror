# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/polkit-qt/polkit-qt-0.103.0.ebuild,v 1.6 2012/08/19 08:02:13 scarabeus Exp $

EAPI=4

MY_P="${P/qt/qt-1}"

inherit cmake-utils

DESCRIPTION="PolicyKit Qt4 API wrapper library."
HOMEPAGE="http://www.kde.org/"
SRC_URI="mirror://kde/stable/apps/KDE4.x/admin/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~x86-fbsd"
SLOT="0"
IUSE="debug examples"

COMMON_DEPEND="
	dev-libs/glib:2
	>=sys-auth/polkit-0.103
	x11-libs/qt-core:4[glib]
	x11-libs/qt-gui:4[dbus,glib]
"
DEPEND="${COMMON_DEPEND}
	dev-util/automoc
"
RDEPEND="${COMMON_DEPEND}"

DOCS=(AUTHORS README README.porting TODO)

S="${WORKDIR}/${MY_P}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build examples)
	)
	cmake-utils_src_configure
}
