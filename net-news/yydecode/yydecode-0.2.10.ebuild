# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/yydecode/yydecode-0.2.10.ebuild,v 1.7 2006/10/04 12:32:49 blubb Exp $

DESCRIPTION="A decoder for yENC format, popular on Usenet"
HOMEPAGE="http://yydecode.sourceforge.net/"
SRC_URI="mirror://sourceforge/yydecode/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ~ppc ~sparc x86"
IUSE=""

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
