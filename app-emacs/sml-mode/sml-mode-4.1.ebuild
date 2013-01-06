# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/sml-mode/sml-mode-4.1.ebuild,v 1.6 2012/11/01 14:42:24 ulm Exp $

inherit elisp

DESCRIPTION="Emacs major mode for editing Standard ML"
HOMEPAGE="http://www.iro.umontreal.ca/~monnier/elisp/"
SRC_URI="http://www.iro.umontreal.ca/~monnier/elisp/${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
IUSE=""
RESTRICT="test"

SITEFILE="50${PN}-gentoo.el"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	elisp-install ${PN} *.el *.elc || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	doinfo *.info* || die
	dodoc BUGS ChangeLog NEWS README TODO || die
}
