# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mic-paren/mic-paren-3.8.ebuild,v 1.3 2008/06/14 23:27:42 ulm Exp $

inherit elisp

DESCRIPTION="Advanced highlighting of matching parentheses"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/MicParen
	http://user.it.uu.se/~mic/emacs.shtml"
# taken from http://www.gnuvola.org/software/j/mic-paren/mic-paren.el
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el
