# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/wol/wol-0.7.1.ebuild,v 1.12 2014/08/10 20:49:10 slyfox Exp $

DESCRIPTION="Wake On LAN client, wakes up hardware that is Magic Packet compliant"
HOMEPAGE="http://ahh.sourceforge.net/wol/"
SRC_URI="mirror://sourceforge/ahh/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~x86-fbsd"
IUSE="nls"

src_compile() {
	econf \
		$(use_enable nls) \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README ChangeLog TODO AUTHORS
}
