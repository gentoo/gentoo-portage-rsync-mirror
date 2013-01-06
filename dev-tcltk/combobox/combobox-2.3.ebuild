# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/combobox/combobox-2.3.ebuild,v 1.5 2011/01/18 15:37:03 tomka Exp $

inherit multilib

DESCRIPTION="A combobox megawidget"
HOMEPAGE="http://www1.clearlight.com/~oakley/tcl/combobox/index.html"
SRC_URI="http://www1.clearlight.com/~oakley/tcl/combobox/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="dev-lang/tcl"
DEPEND=""

src_install() {
	insinto /usr/$(get_libdir)/${P}
	doins *tcl *tmml *n || die
	dodoc *txt || die
	dohtml *html || die
}
