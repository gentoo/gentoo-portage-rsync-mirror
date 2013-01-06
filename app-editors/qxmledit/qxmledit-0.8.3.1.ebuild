# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/qxmledit/qxmledit-0.8.3.1.ebuild,v 1.1 2012/10/29 10:36:45 yngwin Exp $

EAPI=4

inherit multilib eutils qt4-r2

MY_P="qxmledit-${PV}-src"

DESCRIPTION="Qt4 XML Editor"
HOMEPAGE="http://code.google.com/p/qxmledit/"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.tgz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=x11-libs/qt-core-4.7:4
	>=x11-libs/qt-gui-4.7:4
	>=x11-libs/qt-sql-4.7:4
	>=x11-libs/qt-svg-4.7:4
	>=x11-libs/qt-xmlpatterns-4.7:4"
RDEPEND="${DEPEND}"

DOCS="AUTHORS NEWS README ROADMAP TODO"

src_prepare() {
	# fix doc dir
	sed -i "/INST_DOC_DIR = / s|/opt/${PN}|/usr/share/doc/${PF}|" \
		src/QXmlEdit{,Widget}.pro src/sessions/QXmlEditSessions.pro || \
		die "failed to fix doc installation path"
	# fix binary installation path
	sed -i "/INST_DIR = / s|/opt/${PN}|/usr/bin|" \
		src/QXmlEdit{,Widget}.pro src/sessions/QXmlEditSessions.pro || \
		die "failed to fix binary installation path"
	# fix helper libraries installation path
	sed -i "/INST_LIB_DIR = / s|/opt/${PN}|/usr/$(get_libdir)|" \
		src/QXmlEdit{,Widget}.pro \
		src/sessions/QXmlEditSessions.pro || \
		die "failed to fix library installation path"
	# fix translations
	sed -i "/INST_DATA_DIR = / s|/opt|/usr/share|" src/QXmlEdit{,Widget}.pro \
		src/sessions/QXmlEditSessions.pro || \
		die "failed to fix translations"
	# fix include
	sed -i "/INST_INCLUDE_DIR = / s|/opt|/usr/share|" src/QXmlEditWidget.pro \
		|| die "failed to fix include directory"

	qt4-r2_src_prepare
}

src_install() {
	qt4-r2_src_install

	newicon src/images/icon.png ${PN}.png
	make_desktop_entry QXmlEdit QXmlEdit ${PN} "Qt;Utility;TextEditor"
}
