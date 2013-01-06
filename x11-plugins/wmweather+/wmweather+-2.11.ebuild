# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmweather+/wmweather+-2.11.ebuild,v 1.4 2012/06/18 16:24:17 xmw Exp $

inherit flag-o-matic

IUSE=""
DESCRIPTION="A dockapp for displaying data collected from METAR, AVN, ETA, and MRF forecasts"
HOMEPAGE="http://www.sourceforge.net/projects/wmweatherplus/"
SRC_URI="mirror://sourceforge/wmweatherplus/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~mips ppc ~ppc64 ~sparc x86"

DEPEND="x11-wm/windowmaker
	dev-libs/libpcre
	>=net-misc/curl-7.17.1
	x11-libs/libXpm
	x11-libs/libXext
	x11-libs/libX11"

RDEPEND="${DEPEND}"

src_compile() {
	append-flags "-fno-optimize-sibling-calls"

	econf || die
	emake || die
}

src_install() {
	dobin wmweather+
	dodoc ChangeLog HINTS README example.conf
	doman wmweather+.1
}
