# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/scanmem/scanmem-0.07.ebuild,v 1.3 2011/11/22 21:26:55 radhermit Exp $

EAPI=4

inherit autotools

DESCRIPTION="Locate and modify variables in executing processes"
HOMEPAGE="http://taviso.decsystem.org/scanmem.html"
SRC_URI="http://taviso.decsystem.org/files/scanmem/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/readline"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e "/CFLAGS/d" Makefile.am || die
	eautoreconf
}

src_install() {
	dobin scanmem
	doman scanmem.1
	dodoc README TODO ChangeLog
}
