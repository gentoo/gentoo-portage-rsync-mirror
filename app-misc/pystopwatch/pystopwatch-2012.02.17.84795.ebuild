# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pystopwatch/pystopwatch-2012.02.17.84795.ebuild,v 1.1 2012/05/05 12:23:16 xmw Exp $

EAPI=4

PYTHON_DEPEND=2

inherit python

DESCRIPTION="clock and two countdown functions that can minimize to the tray"
HOMEPAGE="http://xyne.archlinux.ca/projects/pystopwatch"
SRC_URI="http://xyne.archlinux.ca/projects/${PN}/archives/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/pygtk:2"
DEPEND=""

src_prepare() {
	unpack ./man/${PN}.1.gz
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
}
