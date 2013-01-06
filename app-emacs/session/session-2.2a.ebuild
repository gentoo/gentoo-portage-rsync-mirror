# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/session/session-2.2a.ebuild,v 1.11 2007/07/10 06:28:03 opfer Exp $

inherit elisp

DESCRIPTION="When you start Emacs, Session restores various variables from your last session."
HOMEPAGE="http://emacs-session.sourceforge.net/index.html"
SRC_URI="mirror://sourceforge/emacs-session/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

S="${WORKDIR}/${PN}"
SITEFILE=50${PN}-gentoo.el

src_compile() {
	cd lisp
	elisp-compile session.el || die "elisp-compile failed"
}

src_install() {
	elisp-install ${PN} lisp/*.el lisp/*.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc INSTALL README lisp/ChangeLog
}

pkg_postinst() {
	elisp-site-regen
	elog "Add the following to your ~/.emacs to use session:"
	elog "	(require 'session)"
	elog "	(add-hook 'after-init-hook 'session-initialize)"
}
