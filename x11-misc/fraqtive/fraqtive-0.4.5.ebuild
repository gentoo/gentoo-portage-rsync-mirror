# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fraqtive/fraqtive-0.4.5.ebuild,v 1.2 2012/07/21 18:53:25 hasufell Exp $

EAPI=4

inherit eutils gnome2-utils qt4-r2

DESCRIPTION="Fraqtive is a KDE-based program for interactively drawing Mandelbrot and Julia fractals"
HOMEPAGE="http://fraqtive.mimec.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sse2"

RDEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-qt-4.8.patch

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
