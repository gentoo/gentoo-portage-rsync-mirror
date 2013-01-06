# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/photopc/photopc-3.06.ebuild,v 1.1 2011/05/11 23:58:22 xmw Exp $

EAPI=2

inherit toolchain-funcs

DESCRIPTION="Utility to control digital cameras based on Sierra Imaging firmware"
HOMEPAGE="http://photopc.sourceforge.net"
SRC_URI="mirror://sourceforge/photopc/${P}.tar.gz"

LICENSE="|| ( BSD as-is )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

src_install() {
	dobin photopc epinfo || die
	doman photopc.1 epinfo.1 || die
}
