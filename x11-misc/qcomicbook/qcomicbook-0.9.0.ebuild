# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/qcomicbook/qcomicbook-0.9.0.ebuild,v 1.3 2014/02/09 13:24:35 pinkbyte Exp $

EAPI=4

CMAKE_IN_SOURCE_BUILD=1
inherit cmake-utils flag-o-matic

DESCRIPTION="A viewer for comic book archives containing jpeg/png images."
HOMEPAGE="http://qcomicbook.org/"
SRC_URI="http://qcomicbook.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="debug"

DEPEND="dev-qt/qtgui:4
	app-text/poppler[qt4]"
RDEPEND="${DEPEND}"

DOCS="AUTHORS ChangeLog NEWS README THANKS TODO"

src_configure() {
	use !debug && append-cppflags -DQT_NO_DEBUG_OUTPUT
	cmake-utils_src_configure
}

pkg_postinst() {
	elog "For using QComicBook with compressed archives you may want to install:"
	elog "    app-arch/p7zip"
	elog "    app-arch/unace"
	elog "    app-arch/unrar or app-arch/rar"
	elog "    app-arch/unzip"
}
