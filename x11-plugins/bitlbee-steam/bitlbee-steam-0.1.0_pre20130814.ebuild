# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/bitlbee-steam/bitlbee-steam-0.1.0_pre20130814.ebuild,v 1.2 2013/08/20 14:15:49 hasufell Exp $

EAPI=5

DESCRIPTION="Steam protocol plugin for BitlBee"
HOMEPAGE="https://github.com/jgeboski/bitlbee-steam"
SRC_URI="http://dev.gentoo.org/~hasufell/distfiles/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1 BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/gmp:0
	>=net-im/bitlbee-3.2[plugins]"
DEPEND="${RDEPEND}
	dev-libs/glib:2
	virtual/pkgconfig"
