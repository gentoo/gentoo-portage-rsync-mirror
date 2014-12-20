# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/bwping/bwping-1.7-r1.ebuild,v 1.4 2014/12/20 12:50:37 hwoarang Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=1
inherit autotools-utils linux-info

DESCRIPTION="A tool to measure bandwidth and RTT between two hosts using ICMP"
HOMEPAGE="http://bwping.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~sparc x86 ~x86-fbsd"
IUSE="ipv6"

PATCHES=(
	 "${FILESDIR}/${P}-buildsystem-configurable-ipv6.patch" # bug 454256
)

CONFIG_CHECK="IPV6"

pkg_setup() {
	if use ipv6; then
		linux-info_pkg_setup
	fi
}

src_configure() {
	local myeconfargs=(
		$(use_enable ipv6)
	)
	autotools-utils_src_configure
}
