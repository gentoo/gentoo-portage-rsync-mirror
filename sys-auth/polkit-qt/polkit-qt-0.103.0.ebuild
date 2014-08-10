# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/polkit-qt/polkit-qt-0.103.0.ebuild,v 1.11 2014/08/10 20:23:08 slyfox Exp $

EAPI=4

MY_P="${P/qt/qt-1}"

inherit cmake-utils

DESCRIPTION="PolicyKit Qt4 API wrapper library"
HOMEPAGE="http://www.kde.org/"
SRC_URI="mirror://kde/stable/apps/KDE4.x/admin/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~x86-fbsd"
SLOT="0"
IUSE="debug examples"

COMMON_DEPEND="
	dev-libs/glib:2
	dev-qt/qtcore:4[glib]
	dev-qt/qtdbus:4
	dev-qt/qtgui:4[glib]
	>=sys-auth/polkit-0.103
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
