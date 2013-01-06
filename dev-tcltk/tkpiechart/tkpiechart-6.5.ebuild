# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tkpiechart/tkpiechart-6.5.ebuild,v 1.6 2010/03/31 20:14:24 jlec Exp $

DESCRIPTION="create and update 2D or 3D pie charts in a Tcl/Tk application"
HOMEPAGE="http://jfontain.free.fr/piechart6.htm"
SRC_URI="http://jfontain.free.fr/${P}.tar.bz2"

LICENSE="as-is"
KEYWORDS="x86 ~ppc ~amd64"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/tk-8.3
	dev-tcltk/tcllib"

src_install() {
	dodir /usr/lib/tkpiechart
	./instapkg.tcl "${D}"/usr/lib/tkpiechart || die

	dodoc CHANGES CONTENTS COPYRIGHT INSTALL README TODO
	dohtml *.gif *.html
	docinto demo
	dodoc demo*
}
