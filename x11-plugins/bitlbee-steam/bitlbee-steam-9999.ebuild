# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/bitlbee-steam/bitlbee-steam-9999.ebuild,v 1.1 2013/08/19 00:41:37 hasufell Exp $

EAPI=5

inherit autotools git-2

DESCRIPTION="Steam protocol plugin for BitlBee"
HOMEPAGE="https://github.com/jgeboski/bitlbee-steam"
EGIT_REPO_URI="https://github.com/jgeboski/bitlbee-steam.git"

LICENSE="GPL-2 LGPL-2.1 BSD-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-libs/gmp:0
	>=net-im/bitlbee-3.2[plugins]"
DEPEND="${RDEPEND}
	dev-libs/glib:2
	virtual/pkgconfig"

src_prepare() {
	eautoreconf
}
