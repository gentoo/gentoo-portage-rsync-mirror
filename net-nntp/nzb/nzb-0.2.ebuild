# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/nzb/nzb-0.2.ebuild,v 1.1 2012/03/27 12:22:41 pesa Exp $

EAPI=4
inherit eutils qt4-r2

DESCRIPTION="A binary news grabber"
HOMEPAGE="http://www.nzb.fi/"
SRC_URI="mirror://sourceforge/nzb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

DOCS="ChangeLog"

src_install() {
	qt4-r2_src_install
	doicon images/nzb.png
	make_desktop_entry nzb
}
