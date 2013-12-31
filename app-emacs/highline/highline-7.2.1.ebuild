# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/highline/highline-7.2.1.ebuild,v 1.7 2013/12/29 14:06:44 ulm Exp $

inherit elisp

DESCRIPTION="Minor mode to highlight current line in buffer"
HOMEPAGE="http://www.emacswiki.org/emacs/HighlineMode"
# taken from: http://www.emacswiki.org/emacs/download/${PN}.el
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 ppc ~s390 x86"
IUSE=""

SITEFILE="51${PN}-gentoo.el"

src_compile() {
	elisp-compile *.el || die
	elisp-make-autoload-file || die
}
