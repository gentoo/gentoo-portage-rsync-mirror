# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/folding/folding-2012.0226.1623.ebuild,v 1.4 2013/02/15 23:03:37 ago Exp $

EAPI=5

inherit elisp

DESCRIPTION="A folding-editor-like Emacs minor mode"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/FoldingMode"
# taken from http://git.savannah.gnu.org/cgit/emacs-tiny-tools.git
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="alpha amd64 x86"

SITEFILE="70${PN}-gentoo.el"
