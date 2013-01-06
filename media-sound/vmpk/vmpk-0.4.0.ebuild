# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vmpk/vmpk-0.4.0.ebuild,v 1.3 2012/07/31 16:17:30 kensington Exp $

EAPI=4

inherit cmake-utils eutils

DESCRIPTION="Virtual MIDI Piano Keyboard"
HOMEPAGE="http://vmpk.sourceforge.net/"
SRC_URI="mirror://sourceforge/vmpk/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus"

RDEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-svg:4
	dbus? ( x11-libs/qt-dbus:4 )
	media-libs/alsa-lib"
DEPEND="${RDEPEND}
	app-text/docbook-xsl-stylesheets
	virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog NEWS README TODO )

src_configure() {
	local mycmakeargs=( "$(cmake-utils_use_enable dbus DBUS)" )
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	rm -rf "${D}/usr/share/doc/packages"
}
