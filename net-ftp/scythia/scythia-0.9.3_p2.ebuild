# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/scythia/scythia-0.9.3_p2.ebuild,v 1.2 2010/04/09 14:36:15 ssuominen Exp $

EAPI=3
inherit gnome2-utils qt4-r2

DESCRIPTION="Just a small FTP client"
HOMEPAGE="http://scythia.free.fr/"
SRC_URI="http://scythia.free.fr/wp-content/${PN}_${PV/_p/-}-src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4"

S=${WORKDIR}/${PN}

DOCS="AUTHORS"

src_prepare() {
	sed -i \
		-e 's:/usr/share/applnk/Internet:/usr/share/applications:g' \
		-e "s:scythia/html:${PF}/html:" \
		scythia.pro || die
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
