# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/juffed/juffed-0.8.1.ebuild,v 1.6 2013/03/02 19:21:14 hwoarang Exp $

EAPI=2

inherit multilib cmake-utils

DESCRIPTION="QScintilla-based tabbed text editor with syntax highlighting"
HOMEPAGE="http://www.qt-apps.org/content/show.php/JuffEd?content=59940"
SRC_URI="mirror://sourceforge/${PN}/${P/-/_}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="debug"

RDEPEND="x11-libs/qscintilla
	dev-qt/qtgui:4"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${P/_/-}

DOCS=( ChangeLog README )

src_prepare() {
	sed -i -e \
		"s:\${CMAKE_INSTALL_PREFIX}/lib:\${CMAKE_INSTALL_PREFIX}/$(get_libdir):" \
		CMakeLists.txt || die "sed failed"
}
