# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/andromeda/andromeda-0.2.1.ebuild,v 1.4 2013/03/02 23:47:01 hwoarang Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="Qt4-based filemanager"
HOMEPAGE="https://gitorious.org/andromeda/pages/Home"
SRC_URI="https://gitorious.org/${PN}/${PN}/archive-tarball/v${PV} -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND=">=dev-qt/qtcore-4.8.0:4
	>=dev-qt/qtgui-4.8.0:4
	>=dev-qt/qtwebkit-4.8.0:4"
DEPEND="${RDEPEND}
	test? ( >=dev-qt/qttest-4.8.0:4 )"
DOCS="TODO.txt dist/changes-*"

src_unpack() {
	default
	mv ${PN}-${PN} "${S}" || die
}

src_prepare() {
	if ! use test ; then
		sed -i -e '/add_subdirectory( tests )/d' CMakeLists.txt || die
	fi
}
