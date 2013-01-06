# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/blogmax/blogmax-20041208.ebuild,v 1.6 2007/07/04 23:32:59 opfer Exp $

inherit elisp

DESCRIPTION="Blogging in Emacs"
HOMEPAGE="http://billstclair.com/blogmax/index.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

src_unpack() {
	unpack ${A}; rm -f *.elc
}

src_install() {
	elisp-install ${PN} blogmax.{el,elc}
	elisp-site-file-install "${FILESDIR}/50blogmax-gentoo.el"
	dodoc "${FILESDIR}/README.Gentoo"
	dodir /usr/share/doc/${PF}/example
	cp -r * "${D}/usr/share/doc/${PF}/example"
	pushd "${D}/usr/share/doc/${PF}/example"
	rm -f blogmax.{el,elc}
}
