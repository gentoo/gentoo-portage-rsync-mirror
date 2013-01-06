# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iftop/iftop-1.0_pre2.ebuild,v 1.4 2012/07/23 12:27:07 blueness Exp $

EAPI=4

DESCRIPTION="display bandwidth usage on an interface"
SRC_URI="http://www.ex-parrot.com/~pdw/iftop/download/${P/_/}.tar.gz"
HOMEPAGE="http://www.ex-parrot.com/~pdw/iftop/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

# We need libpcap with ipv6 support or else iftop doesn't work at all.
DEPEND="
	net-libs/libpcap[ipv6]
	sys-libs/ncurses"

S="${WORKDIR}"/${P/_/}

src_install() {
	dosbin iftop
	doman iftop.8

	dodoc AUTHORS ChangeLog README "${FILESDIR}"/iftoprc
}
