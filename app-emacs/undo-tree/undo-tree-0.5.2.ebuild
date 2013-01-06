# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/undo-tree/undo-tree-0.5.2.ebuild,v 1.1 2012/07/15 18:02:26 ulm Exp $

EAPI=4
NEED_EMACS=22

inherit elisp

DESCRIPTION="Undo trees and visualization"
HOMEPAGE="http://www.dr-qubit.org/emacs.php#undo-tree"
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE="50${PN}-gentoo.el"

pkg_postinst() {
	elisp-site-regen
	elog "To enable undo trees globally, place '(global-undo-tree-mode)'"
	elog "in your .emacs file."
}
