# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wbar/wbar-2.2.2.ebuild,v 1.4 2014/08/10 20:04:28 slyfox Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="A fast, lightweight quick launch bar"
HOMEPAGE="http://code.google.com/p/wbar/"
SRC_URI="http://wbar.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk"

RDEPEND="media-libs/imlib2[X]
	x11-libs/libX11
	gtk? ( dev-libs/atk
		dev-libs/glib:2
		dev-libs/libxml2
		gnome-base/libglade
		media-libs/fontconfig
		media-libs/freetype
		media-libs/libpng
		x11-libs/cairo
		x11-libs/gdk-pixbuf
		x11-libs/gtk+:2 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

src_prepare() {
	if ! use gtk; then
		# Remove wbar-config from default cfg.
		sed -i -e '5,8d' etc/wbar.cfg.in || die
	fi
	sed -i -e '/Werror/d' src/Makefile.am || die
	eautoreconf
}

src_configure() {
	econf --bindir=/usr/bin $(use_enable gtk wbar-config)
}
