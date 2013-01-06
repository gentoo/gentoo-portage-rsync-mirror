# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/qlipper/qlipper-2.0.1.ebuild,v 1.1 2012/09/02 09:13:25 yngwin Exp $

EAPI=4
PLOCALES="cs sr"
inherit l10n cmake-utils

DESCRIPTION="Lightweight and cross-platform clipboard history applet"
HOMEPAGE="http://code.google.com/p/qlipper/"
SRC_URI="http://qlipper.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

src_prepare() {
	l10n_for_each_disabled_locale_do rm_loc
}

src_configure() {
	cmake-utils_src_configure INSTALL_PREFIX="${EPREFIX}"/usr
}

rm_loc() {
	rm ts/${PN}.${1}.*
}
