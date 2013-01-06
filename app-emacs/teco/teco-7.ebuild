# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/teco/teco-7.ebuild,v 1.2 2011/11/24 17:58:43 ulm Exp $

EAPI=4

inherit elisp

DESCRIPTION="TECO interpreter for GNU Emacs"
HOMEPAGE="http://www.emacswiki.org/emacs/TECO"
# taken from: http://www.emacswiki.org/emacs/teco.el
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ELISP_PATCHES="${P}-minibuffer-prompt.patch"
SITEFILE="50${PN}-gentoo.el"

pkg_postinst() {
	elisp-site-regen
	elog "To be able to invoke Teco directly, define a key binding"
	elog "for teco:command in your ~/.emacs file, e.g.:"
	elog "  (global-set-key \"\\C-z\" 'teco:command)"
	elog "See ${SITELISP}/${PN}/teco.el for documentation."
}
