# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cclive/cclive-0.7.10-r1.ebuild,v 1.4 2012/12/16 13:52:36 ago Exp $

EAPI=4

DESCRIPTION="Command line tool for extracting videos from various websites"
HOMEPAGE="http://cclive.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PV:0:3}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE=""

RDEPEND=">=media-libs/libquvi-0.4.0
	>=dev-libs/boost-1.42
	>=net-misc/curl-7.20
	>=dev-libs/libpcre-8.02[cxx]"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	virtual/pkgconfig"

src_configure() {
	econf --disable-ccl
}
