# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/qgoogletranslator/qgoogletranslator-1.2.1-r1.ebuild,v 1.5 2013/03/02 19:44:40 hwoarang Exp $
EAPI="4"
inherit cmake-utils fdo-mime

DESCRIPTION="GUI for google translate web service"
HOMEPAGE="http://code.google.com/p/qgt/"
SRC_URI="http://qgt.googlecode.com/files/${P}.tar.bz2"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RDEPEND="dev-qt/qtgui:4"
DEPEND="${RDEPEND}"
DOCS="Changelog.txt"
PATCHES=( "${FILESDIR}/${P}_gcc47.patch" )

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
