# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/fstrm/fstrm-0.2.0-r1.ebuild,v 1.2 2014/11/27 18:17:41 radhermit Exp $

EAPI=5
inherit autotools-multilib

DESCRIPTION="Frame Streams implementation in C"
HOMEPAGE="https://github.com/farsightsec/fstrm"
SRC_URI="https://github.com/farsightsec/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs utils"

RDEPEND="utils? ( dev-libs/libevent[${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig[${MULTILIB_USEDEP}]"

src_configure() {
	local myeconfargs=(
		$(use_enable utils programs)
	)
	autotools-multilib_src_configure
}
