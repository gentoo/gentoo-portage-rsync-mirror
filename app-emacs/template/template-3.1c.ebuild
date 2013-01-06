# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/template/template-3.1c.ebuild,v 1.1 2008/01/23 13:57:14 opfer Exp $

inherit elisp

DESCRIPTION="Use templates, decorate comments, auto-update buffers"
HOMEPAGE="http://emacs-template.sourceforge.net/"
SRC_URI="mirror://sourceforge/emacs-template/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el
S="${WORKDIR}/${PN}"

src_compile() {
	elisp-compile lisp/*.el || die "elisp-compile failed"
}

src_install() {
	elisp-install ${PN} lisp/*.{el,elc} || die "elisp-install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
		|| die "elisp-site-file-install failed"

	insinto "${SITELISP}/${PN}/templates"
	doins templates/*.tpl || die "doins failed"
	dodoc README lisp/ChangeLog || die "dodoc failed"
}
