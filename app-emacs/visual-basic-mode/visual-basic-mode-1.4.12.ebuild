# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/visual-basic-mode/visual-basic-mode-1.4.12.ebuild,v 1.1 2013/12/07 11:17:58 ulm Exp $

EAPI=5

inherit elisp

DESCRIPTION="A mode for editing Visual Basic programs"
HOMEPAGE="http://www.emacswiki.org/emacs/VisualBasicMode"
# taken from http://www.emacswiki.org/emacs/${PN}.el
SRC_URI="http://dev.gentoo.org/~ulm/distfiles/${P}.el.xz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

SITEFILE="50${PN}-gentoo.el"
