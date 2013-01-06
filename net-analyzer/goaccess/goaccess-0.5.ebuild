# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/goaccess/goaccess-0.5.ebuild,v 1.1 2012/07/27 05:24:20 yngwin Exp $

EAPI=4

DESCRIPTION="A real-time Apache log analyzer and interactive viewer that runs in a terminal"
HOMEPAGE="http://goaccess.prosoftcorp.com"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE="geoip unicode"

RDEPEND="
	dev-libs/glib:2
	sys-libs/ncurses[unicode?]
	geoip? ( dev-libs/geoip )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

src_configure() {
	econf $(use_enable geoip) $(use_enable unicode utf8)
}
