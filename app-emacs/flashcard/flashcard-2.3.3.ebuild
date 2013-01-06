# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/flashcard/flashcard-2.3.3.ebuild,v 1.5 2008/12/01 19:45:52 tcunha Exp $

inherit elisp

DESCRIPTION="An Emacs Lisp package for drilling on questions and answers."
HOMEPAGE="http://ichi2.net/flashcard/
	http://www.emacswiki.org/cgi-bin/wiki/FlashCard"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="amd64 ~ppc sparc x86"

SITEFILE=50flashcard-gentoo.el
