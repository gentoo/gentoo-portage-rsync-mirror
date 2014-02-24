# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/edb/edb-1.31.ebuild,v 1.3 2014/02/24 08:08:38 ulm Exp $

EAPI=5

inherit elisp

DESCRIPTION="EDB, The Emacs Database"
HOMEPAGE="http://www.gnuvola.org/software/edb/
	http://www.emacswiki.org/emacs/EmacsDataBase"
SRC_URI="http://www.gnuvola.org/software/edb/${P}.tar.gz"

LICENSE="GPL-3+ Texinfo-manual"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

ELISP_PATCHES="${P}-skram-path.patch"
SITEFILE="50${PN}-gentoo.el"

src_configure() {
	default
}

src_compile() {
	emake -j1
}

src_install() {
	einstall sitelisp="${D}${SITELISP}"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc AUTHORS BUGS ChangeLog HACKING NEWS README THANKS TODO doc/refcard.ps
	insinto /usr/share/doc/${PF}; doins -r examples
}
