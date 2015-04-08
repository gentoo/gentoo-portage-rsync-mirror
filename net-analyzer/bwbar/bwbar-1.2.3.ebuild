# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/bwbar/bwbar-1.2.3.ebuild,v 1.6 2014/07/10 19:47:09 jer Exp $

EAPI=5
inherit eutils

DESCRIPTION="The kernel.org \"Current bandwidth utilization\" bar"
HOMEPAGE="http://www.kernel.org/pub/software/web/bwbar/"
SRC_URI="mirror://kernel/software/web/bwbar/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND=">=media-libs/libpng-1.2"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libpng15.patch
}

src_install() {
	dobin bwbar
	dodoc README
}
