# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/qlipper/qlipper-2.0.0-r1.ebuild,v 1.2 2013/03/02 23:51:31 hwoarang Exp $

EAPI=4
PLOCALES="cs sr"
inherit l10n qt4-r2

DESCRIPTION="Lightweight and cross-platform clipboard history applet"
HOMEPAGE="http://code.google.com/p/qlipper/"
SRC_URI="http://qlipper.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtgui:4"
RDEPEND="${DEPEND}"

src_prepare() {
	l10n_for_each_disabled_locale_do rm_loc
}

src_configure() {
	eqmake4 ${PN}2.pro INSTALL_PREFIX="${EPREFIX}"/usr
}

rm_loc() {
	rm ts/${PN}.${1}.*
}
