# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/combobox/combobox-2.3.ebuild,v 1.6 2013/04/07 22:08:53 ulm Exp $

inherit multilib

DESCRIPTION="A combobox megawidget"
HOMEPAGE="http://www1.clearlight.com/~oakley/tcl/combobox/index.html"
SRC_URI="http://www1.clearlight.com/~oakley/tcl/combobox/${P}.tar.gz"

LICENSE="freedist"
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
