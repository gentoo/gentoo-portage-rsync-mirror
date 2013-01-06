# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xournal/xournal-0.4.6-r1.ebuild,v 1.1 2012/06/24 11:08:44 dilfridge Exp $

EAPI=4

GCONF_DEBUG=no

inherit gnome2 autotools

DESCRIPTION="Xournal is an application for notetaking, sketching, and keeping a journal using a stylus."
HOMEPAGE="http://xournal.sourceforge.net/"

SRC_URI="http://dev.gentoo.org/~dilfridge/distfiles/${P}.tar.xz http://dev.gentoo.org/~dilfridge/distfiles/${PN}-${PVR}-gentoo.patch.xz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+pdf"

COMMONDEPEND="
	app-text/poppler[cairo]
	dev-libs/atk
	dev-libs/glib
	gnome-base/libgnomecanvas
	media-libs/freetype
	media-libs/fontconfig
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	x11-libs/pango
"
RDEPEND="${COMMONDEPEND}
	pdf? ( app-text/poppler[utils] app-text/ghostscript-gpl )
"
DEPEND="${COMMONDEPEND}
	virtual/pkgconfig
"

src_prepare() {
	epatch "${WORKDIR}"/${PN}-${PVR}-gentoo.patch
	sed -e "s:n       http:n       Gentoo release ${PVR}\\\\n       http:" -i "${S}"/src/xo-interface.c
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
	emake DESTDIR="${D}" desktop-install

	dodoc ChangeLog AUTHORS README
	dohtml -r html-doc/*
}
