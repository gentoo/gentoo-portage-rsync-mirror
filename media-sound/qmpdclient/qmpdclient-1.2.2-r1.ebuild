# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qmpdclient/qmpdclient-1.2.2-r1.ebuild,v 1.4 2012/07/10 17:53:33 ranger Exp $

EAPI=4
inherit fdo-mime cmake-utils

DESCRIPTION="QMPDClient with NBL additions, such as lyrics' display"
HOMEPAGE="http://bitcheese.net/wiki/QMPDClient"
SRC_URI="http://dump.bitcheese.net/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
KEYWORDS="amd64 ppc x86"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4[dbus]
	x11-libs/qt-webkit:4
	x11-libs/qt-xmlpatterns:4"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

DOCS=( AUTHORS README THANKSTO )
PATCHES=( "${FILESDIR}"/${P}-qt48.patch )

src_prepare() {
	sed -i -e "/^Categories/s/Network/AudioVideo/" ${PN}.desktop || die
	base_src_prepare
}

src_configure() {
	local mycmakeargs=( "-DVERSION=${PV}" )
	cmake-utils_src_configure
}

pkg_postinst() { fdo-mime_desktop_database_update; }
pkg_postrm() { fdo-mime_desktop_database_update; }
