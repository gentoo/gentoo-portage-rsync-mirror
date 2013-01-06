# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/whdd/whdd-1.0.ebuild,v 1.1 2012/08/10 14:47:56 maksbotan Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="Diagnostic and recovery tool for block devices"
HOMEPAGE="http://github.com/krieger-od/whdd"
SRC_URI="http://github.com/krieger-od/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-util/dialog
	sys-libs/ncurses[unicode]"
RDEPEND="${DEPEND}
	sys-apps/smartmontools"

src_unpack() {
	default
	mv krieger-od-${PN}-* ${P}
}
