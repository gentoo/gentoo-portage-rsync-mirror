# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/andromeda/andromeda-0.3.ebuild,v 1.2 2015/03/29 05:23:14 yngwin Exp $

EAPI=5
inherit cmake-utils

DESCRIPTION="Qt4-based filemanager"
HOMEPAGE="https://github.com/ABBAPOH/andromeda"
SRC_URI="http://dev.gentoo.org/~yngwin/distfiles/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="pdf"

RDEPEND=">=dev-qt/qtcore-4.8.0:4
	>=dev-qt/qtdbus-4.8.0:4
	>=dev-qt/qtgui-4.8.0:4
	>=dev-qt/qtopengl-4.8.0:4
	>=dev-qt/qtwebkit-4.8.0:4
	pdf? ( app-text/poppler )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}-${PN}

DOCS="TODO.txt dist/changes-*"

src_configure() {
	# avoid building manual-only tests
	local mycmakeargs=(
		-DDISABLE_TESTS=true
		$(cmake-utils_use_find_package pdf PopplerQt4)
	)

	cmake-utils_src_configure
}
