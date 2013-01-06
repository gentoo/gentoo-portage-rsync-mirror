# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/folding/folding-2007.0506.ebuild,v 1.3 2009/06/07 18:59:24 klausman Exp $

inherit elisp

DESCRIPTION="A folding-editor-like Emacs minor mode"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/FoldingMode"
# taken from http://tiny-tools.cvs.sourceforge.net/*checkout*/tiny-tools/tiny-tools/lisp/other/folding.el
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 x86"
IUSE=""

SITEFILE="70${PN}-gentoo.el"
