# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/scwoop/scwoop-4.1.ebuild,v 1.6 2005/04/24 10:59:19 blubb Exp $

DESCRIPTION="Simple Composite Widget Object Oriented Package"
HOMEPAGE="http://jfontain.free.fr/scwoop41.htm"
SRC_URI="http://jfontain.free.fr/${P}.tar.gz"

LICENSE="as-is"
KEYWORDS="x86 amd64 ~ppc"
SLOT="0"
IUSE=""

DEPEND="dev-tcltk/tcllib"

src_install() {
	dodir /usr/lib/scwoop
	./instapkg.tcl ${D}/usr/lib/scwoop || die

	dodoc CHANGES CONTENTS COPYRIGHT INSTALL README TODO
	dohtml scwoop.htm
	docinto demo
	dodoc demo*
}
