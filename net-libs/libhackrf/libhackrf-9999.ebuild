# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libhackrf/libhackrf-9999.ebuild,v 1.1 2013/05/25 15:28:15 zerochaos Exp $

EAPI=5

inherit cmake-utils git-2

DESCRIPTION="library for communicating with HackRF SDR platform"
HOMEPAGE="https://github.com/mossmann/hackrf"
EGIT_REPO_URI="https://github.com/mossmann/hackrf.git"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND="virtual/libusb:1"
RDEPEND="${DEPEND}"

EGIT_SOURCEDIR=${WORKDIR}/${P}
S="${WORKDIR}/${P}/host/libhackrf"
