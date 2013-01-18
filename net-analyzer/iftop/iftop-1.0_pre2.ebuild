# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iftop/iftop-1.0_pre2.ebuild,v 1.5 2013/01/18 14:55:17 polynomial-c Exp $

EAPI=4

DESCRIPTION="display bandwidth usage on an interface"
SRC_URI="http://www.ex-parrot.com/~pdw/iftop/download/${P/_/}.tar.gz"
HOMEPAGE="http://www.ex-parrot.com/~pdw/iftop/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND="
	net-libs/libpcap
	sys-libs/ncurses"

S="${WORKDIR}"/${P/_/}

src_install() {
	dosbin iftop
	doman iftop.8

	dodoc AUTHORS ChangeLog README "${FILESDIR}"/iftoprc
}
