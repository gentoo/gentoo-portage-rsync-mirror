# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/photopc/photopc-3.07.ebuild,v 1.1 2012/10/08 08:58:20 kensington Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="Utility to control digital cameras based on Sierra Imaging firmware"
HOMEPAGE="http://photopc.sourceforge.net"
SRC_URI="mirror://sourceforge/photopc/${P}.tar.gz"

LICENSE="|| ( BSD as-is )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

src_install() {
	dodoc README
	dobin photopc epinfo
	doman photopc.1 epinfo.1
}
