# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/andromeda/andromeda-0.2.1.ebuild,v 1.3 2012/05/19 03:41:05 yngwin Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="Qt4-based filemanager"
HOMEPAGE="https://gitorious.org/andromeda/pages/Home"
SRC_URI="https://gitorious.org/${PN}/${PN}/archive-tarball/v${PV} -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND=">=x11-libs/qt-core-4.8.0:4
	>=x11-libs/qt-gui-4.8.0:4
	>=x11-libs/qt-webkit-4.8.0:4"
DEPEND="${RDEPEND}
	test? ( >=x11-libs/qt-test-4.8.0:4 )"
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
