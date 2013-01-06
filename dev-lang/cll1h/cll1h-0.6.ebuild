# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/cll1h/cll1h-0.6.ebuild,v 1.5 2010/01/02 18:37:29 fauli Exp $

DESCRIPTION="C<<1 programming language system"
HOMEPAGE="http://gpl.arachne.cz/"
SRC_URI="http://gpl.arachne.cz/download/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~ppc ~x86 ~x86-linux ~ppc-macos"
IUSE=""
DEPEND=""
RDEPEND="sys-devel/gcc"

src_install() {
	insinto /usr/include
	doins cll1.h
	dodoc cll1.txt
	docinto examples
	dodoc demos/*.c
}
