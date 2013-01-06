# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/paredit/paredit-22.ebuild,v 1.1 2010/10/09 21:01:34 ulm Exp $

inherit elisp

DESCRIPTION="Minor mode for performing structured editing of S-expressions"
HOMEPAGE="http://mumble.net/~campbell/emacs/
	http://www.emacswiki.org/cgi-bin/wiki/ParEdit"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

SITEFILE="50${PN}-gentoo.el"

src_install() {
	elisp_src_install
	dohtml *.html || die
}
