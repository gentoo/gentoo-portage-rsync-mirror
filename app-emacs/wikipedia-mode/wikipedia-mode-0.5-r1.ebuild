# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/wikipedia-mode/wikipedia-mode-0.5-r1.ebuild,v 1.4 2009/03/21 17:01:52 armin76 Exp $

inherit elisp eutils

DESCRIPTION="Mode for editing Wikipedia articles off-line"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/WikipediaMode"
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="outline-magic"

DEPEND="outline-magic? ( app-emacs/outline-magic )"
RDEPEND="${DEPEND}"

SITEFILE="50${PN}-gentoo.el"

src_unpack() {
	elisp_src_unpack
	use outline-magic && epatch "${FILESDIR}/${P}-require-outline-magic.patch"
}
