# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/esekeyd/esekeyd-1.2.1.ebuild,v 1.6 2006/11/05 23:59:11 opfer Exp $

DESCRIPTION="Multimedia key daemon that uses the Linux event interface"
HOMEPAGE="http://www.majdom.com/~einstein/#esekeydaemon"
LICENSE="GPL-2"

SRC_URI="http://www.majdom.com/~einstein/files/${P}.tar.gz"

SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

DEPEND=""

src_install() {
	make DESTDIR="${D}" install || die

	dodoc ChangeLog AUTHORS README TODO examples/example.conf NEWS
}
