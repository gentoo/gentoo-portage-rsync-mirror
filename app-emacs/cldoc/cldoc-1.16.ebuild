# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/cldoc/cldoc-1.16.ebuild,v 1.3 2008/06/14 23:22:46 ulm Exp $

inherit elisp

DESCRIPTION="Show Common Lisp operators and variables information in echo area"
HOMEPAGE="http://homepage1.nifty.com/bmonkey/lisp/index-en.html"
# taken from http://homepage1.nifty.com/bmonkey/emacs/elisp/cldoc.el
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="app-emacs/slime"

SITEFILE=50${PN}-gentoo.el
