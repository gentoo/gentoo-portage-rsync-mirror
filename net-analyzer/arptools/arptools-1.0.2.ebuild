# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/arptools/arptools-1.0.2.ebuild,v 1.1 2007/03/31 16:02:43 vanquirius Exp $

DESCRIPTION="a collection of libnet and libpcap based ARP utilities."
HOMEPAGE="http://www.burghardt.pl/wiki/software/arptools"
SRC_URI="http://www.burghardt.pl/wiki/_media/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="net-libs/libnet
	net-libs/libpcap"

src_install() {
	# BUG: the tools are installed under /usr/sbin
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
