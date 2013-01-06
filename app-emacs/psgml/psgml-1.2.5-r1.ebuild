# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/psgml/psgml-1.2.5-r1.ebuild,v 1.12 2012/02/05 18:20:25 armin76 Exp $

inherit elisp

IUSE=""

DESCRIPTION="A GNU Emacs Major Mode for editing SGML and XML coded documents."
HOMEPAGE="http://sourceforge.net/projects/psgml/"
SRC_URI="mirror://sourceforge/psgml/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

DEPEND="app-text/openjade"
RDEPEND="${DEPEND}"

SITEFILE=50psgml-gentoo.el

src_compile() {
	emacs --batch --no-site-file --no-init-file \
		--load psgml-maint.el -f psgml-compile-files || die "elisp compilaion failed"
}

src_install() {
	elisp-install ${PN} *.el *.elc *.map
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc ChangeLog INSTALL README.psgml psgml.ps
	doinfo psgml-api.info psgml.info
}
