# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/enet/enet-1.0.ebuild,v 1.6 2010/07/11 19:08:02 scarabeus Exp $

DESCRIPTION="relatively thin, simple and robust network communication layer on top of UDP"
HOMEPAGE="http://enet.bespin.org/"
SRC_URI="http://enet.bespin.org/download/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="ppc"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc *.txt README
}
