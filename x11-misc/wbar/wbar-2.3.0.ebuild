# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wbar/wbar-2.3.0.ebuild,v 1.6 2012/07/29 20:16:13 hasufell Exp $

EAPI=4

inherit eutils flag-o-matic

DESCRIPTION="A fast, lightweight quick launch bar"
HOMEPAGE="http://code.google.com/p/wbar/"
SRC_URI="http://${PN}.googlecode.com/files/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gtk"

RDEPEND="media-libs/imlib2[X]
	virtual/init
	x11-libs/libX11
	gtk? ( gnome-base/libglade
		media-libs/freetype:2
		x11-libs/gdk-pixbuf:2
		x11-libs/gtk+:2 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

src_prepare() {
	use gtk || epatch "${FILESDIR}"/${P}-cfg.patch
}

src_configure() {
	append-flags -Wno-error
	econf \
		$(use_enable gtk wbar-config)
}
