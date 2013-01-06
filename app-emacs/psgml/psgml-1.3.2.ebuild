# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/psgml/psgml-1.3.2.ebuild,v 1.6 2012/02/05 18:20:25 armin76 Exp $

inherit elisp

DESCRIPTION="A GNU Emacs Major Mode for editing SGML and XML coded documents"
HOMEPAGE="http://sourceforge.net/projects/psgml/"
SRC_URI="mirror://sourceforge/psgml/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="app-text/openjade"
RDEPEND="${DEPEND}"

SITEFILE="50${PN}-gentoo.el"

src_compile() {
	emacs --batch --no-site-file --no-init-file \
		--load psgml-maint.el -f psgml-compile-files || die
}

src_install() {
	elisp-install ${PN} *.el *.elc *.map || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	dodoc ChangeLog INSTALL README.psgml psgml.ps || die
	doinfo psgml-api.info psgml.info || die
}
