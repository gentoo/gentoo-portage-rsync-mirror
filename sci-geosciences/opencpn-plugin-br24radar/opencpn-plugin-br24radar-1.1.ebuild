# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/opencpn-plugin-br24radar/opencpn-plugin-br24radar-1.1.ebuild,v 1.2 2015/01/21 23:23:30 mschiff Exp $

EAPI=5

inherit cmake-utils

MY_PN="BR24radar_pi"

DESCRIPTION="Navico (Simrad, Lowrance) Broadband BR24/3G/4G Radar Plugin for OpenCPN"
HOMEPAGE="http://opencpn-navico-radar-plugin.github.io/"
SRC_URI="
	https://github.com/canboat/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=sci-geosciences/opencpn-4.0.0
	sys-devel/gettext
"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"
