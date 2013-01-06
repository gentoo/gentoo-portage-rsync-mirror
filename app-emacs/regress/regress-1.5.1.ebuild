# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/regress/regress-1.5.1.ebuild,v 1.6 2009/03/30 13:09:44 ulm Exp $

inherit elisp

DESCRIPTION="Regression test harness for Emacs Lisp code"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/WikifiedEmacsLispList"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
IUSE=""

ELISP_PATCHES="${PV}-regress.el-gentoo.patch"
SITEFILE="50${PN}-gentoo.el"
