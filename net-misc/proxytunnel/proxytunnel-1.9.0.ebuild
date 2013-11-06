# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/proxytunnel/proxytunnel-1.9.0.ebuild,v 1.3 2013/11/06 03:08:03 patrick Exp $

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Connect stdin and stdout to a server somewhere on the network, through a standard HTTPS proxy"
HOMEPAGE="http://proxytunnel.sourceforge.net/"
SRC_URI="mirror://sourceforge/proxytunnel/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="static"

RDEPEND="dev-libs/openssl"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_compile() {
	use static && append-ldflags -static
	emake CC="$(tc-getCC)" || die
}

src_install() {
	emake install PREFIX=/usr DESTDIR="${D}" || die
	dodoc CHANGES CREDITS KNOWN_ISSUES README
}
