# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/undo-tree/undo-tree-0.6.3.ebuild,v 1.2 2013/07/19 17:17:07 ulm Exp $

EAPI=4
NEED_EMACS=22

inherit readme.gentoo elisp

DESCRIPTION="Undo trees and visualization"
HOMEPAGE="http://www.dr-qubit.org/emacs.php#undo-tree"
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

SITEFILE="50${PN}-gentoo.el"
DOC_CONTENTS="To enable undo trees globally, place '(global-undo-tree-mode)'
	in your .emacs file."
