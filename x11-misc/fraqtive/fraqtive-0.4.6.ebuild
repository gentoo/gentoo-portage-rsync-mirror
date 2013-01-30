# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fraqtive/fraqtive-0.4.6.ebuild,v 1.1 2013/01/30 20:50:19 jer Exp $

EAPI=4
inherit eutils gnome2-utils qt4-r2

DESCRIPTION="an open source, multi-platform generator of the Mandelbrot family fractals"
HOMEPAGE="http://fraqtive.mimec.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sse2"

DEPEND="
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
"
RDEPEND="${DEPEND}"

src_configure() {
	local conf="release"

	if use sse2; then
		conf="$conf sse2"
	else
		conf="$conf no-sse2"
	fi

	echo "CONFIG += $conf" > "${S}"/config.pri
	echo "PREFIX = ${EPREFIX}/usr" >> "${S}"/config.pri
	# Don't strip wrt #252096
	echo "QMAKE_STRIP =" >> "${S}"/config.pri

	qt4-r2_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
