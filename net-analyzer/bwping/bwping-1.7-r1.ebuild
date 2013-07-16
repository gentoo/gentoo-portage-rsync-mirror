# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/bwping/bwping-1.7-r1.ebuild,v 1.1 2013/07/16 20:33:01 pinkbyte Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=1
inherit autotools-utils

DESCRIPTION="A tool to measure bandwidth and RTT between two hosts using ICMP"
HOMEPAGE="http://bwping.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86 ~x86-fbsd"
IUSE="ipv6"

PATCHES=(
	 "${FILESDIR}/${P}-buildsystem-configurable-ipv6.patch" # bug 454256
)

src_configure() {
	local myeconfargs=(
		$(use_enable ipv6)
	)
	autotools-utils_src_configure
}
