# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/yydecode/yydecode-0.2.9.ebuild,v 1.7 2004/06/25 00:27:44 agriffis Exp $

DESCRIPTION="A decoder for yENC format, popular on Usenet"
HOMEPAGE="http://yydecode.sourceforge.net/"
SRC_URI="mirror://sourceforge/yydecode/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc alpha arm"
IUSE=""

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README
}
