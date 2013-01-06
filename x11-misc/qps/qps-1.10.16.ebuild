# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/qps/qps-1.10.16.ebuild,v 1.1 2012/02/02 13:16:24 johu Exp $

EAPI=4

inherit eutils qt4-r2

DESCRIPTION="Visual process manager - Qt version of ps/top"
HOMEPAGE="http://qps.kldp.net/projects/qps/"
SRC_URI="http://kldp.net/frs/download.php/5963/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-core:4
	x11-libs/qt-dbus:4
	x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e '/strip/d' ${PN}.pro || die "sed failed"
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc CHANGES

	newicon icon/icon.xpm ${PN}.xpm
	make_desktop_entry ${PN} ${PN} ${PN} "System;"
}
