# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dnstop/dnstop-20110502.ebuild,v 1.5 2013/01/12 14:35:31 pinkbyte Exp $

EAPI=2
inherit eutils

DESCRIPTION="Displays various tables of DNS traffic on your network."
HOMEPAGE="http://dnstop.measurement-factory.com/"
SRC_URI="http://dnstop.measurement-factory.com/src/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ~ppc x86"
IUSE="ipv6"

RDEPEND="sys-libs/ncurses
	net-libs/libpcap"
DEPEND="${RDEPEND}"

src_configure() {
	econf \
		$(use_enable ipv6)
}

src_install() {
	dobin dnstop || die
	doman dnstop.8
	dodoc CHANGES
}
