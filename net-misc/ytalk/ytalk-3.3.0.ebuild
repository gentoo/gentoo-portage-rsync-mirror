# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ytalk/ytalk-3.3.0.ebuild,v 1.10 2009/09/23 19:49:43 patrick Exp $

DESCRIPTION="Multi-user replacement for UNIX talk"
HOMEPAGE="http://www.impul.se/ytalk/"
SRC_URI="http://www.impul.se/ytalk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ~ia64 ppc ~ppc64 sparc x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2"

src_compile() {
	econf || die "./configure failed"

	emake || die "Parallel Make Failed"
}

src_install() {
	einstall || die "Installation Failed"

	dodoc ChangeLog INSTALL README
}
