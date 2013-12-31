# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/geoipupdate/geoipupdate-2.0.0.ebuild,v 1.3 2013/12/26 14:59:08 maekke Exp $

EAPI=5

DESCRIPTION="performs automatic updates of GeoIP2 and GeoIP Legacy binary databases"
HOMEPAGE="https://github.com/maxmind/geoipupdate"
SRC_URI="https://github.com/maxmind/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86 ~x86-fbsd"
IUSE=""

DEPEND="
	net-misc/curl
	sys-libs/zlib
"
RDEPEND="
	${DEPEND}
	!<dev-libs/geoip-1.6.0
"
