# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cbugzilla/cbugzilla-0.1.1.ebuild,v 1.1 2013/05/28 08:19:58 yac Exp $

EAPI=5

inherit autotools

DESCRIPTION="CLI and C api to get data from Bugzilla"
HOMEPAGE="https://github.com/yaccz/cbugzilla"
SRC_URI="https://github.com/yaccz/${PN}/archive/v/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-misc/curl
	dev-libs/libxdg-basedir"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-v-${PV}

src_prepare() {
	eautoreconf
}
