# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ipv6calc/ipv6calc-0.90.0-r1.ebuild,v 1.6 2012/02/14 21:06:58 ranger Exp $

EAPI="4"
inherit fixheadtails

DESCRIPTION="IPv6 address calculator"
HOMEPAGE="http://www.deepspace6.net/projects/ipv6calc.html"
SRC_URI="ftp://ftp.bieringer.de/pub/linux/IPv6/ipv6calc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ppc sparc x86"
IUSE="geoip"

DEPEND="geoip? ( >=dev-libs/geoip-1.4.7 )"

src_prepare() {
	ht_fix_file configure
}

src_configure() {
	econf $(use_enable geoip)
}

src_compile() {
	# Disable default CFLAGS (-O2 and -g)
	emake DEFAULT_CFLAGS=""
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc ChangeLog CREDITS README TODO USAGE
}
