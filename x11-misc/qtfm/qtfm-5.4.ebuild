# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/qtfm/qtfm-5.4.ebuild,v 1.3 2012/06/20 06:35:45 jdhore Exp $

EAPI=4
inherit fdo-mime qt4-r2

DESCRIPTION="A small, lightweight file manager for desktops based on pure Qt"
HOMEPAGE="http://www.qtfm.org/"
SRC_URI="http://www.qtfm.org/${P}.tar.gz?attredirects=0 -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# file is for LIBS += -lmagic
RDEPEND="sys-apps/file
	x11-libs/qt-gui:4"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i \
		-e "/^docs.path/s:qtfm:${PF}:" \
		-e '/^docs.files/s: COPYING::' \
		qtfm.pro || die
}

pkg_postinst() { fdo-mime_desktop_database_update; }
pkg_postrm() { fdo-mime_desktop_database_update; }
