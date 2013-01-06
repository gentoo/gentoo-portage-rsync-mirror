# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmsystemtray/wmsystemtray-1.2.ebuild,v 1.1 2012/02/22 11:29:03 voyageur Exp $

EAPI=4

DESCRIPTION="a system tray dockapp with the ability to display more than just four tray icons"
HOMEPAGE="http://sourceforge.net/projects/wmsystemtray/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXmu"
RDEPEND="${DEPEND}"
