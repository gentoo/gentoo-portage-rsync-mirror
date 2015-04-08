# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/highline/highline-7.2.2.ebuild,v 1.4 2014/03/05 15:16:56 ago Exp $

EAPI=5

inherit elisp

DESCRIPTION="Minor mode to highlight current line in buffer"
HOMEPAGE="http://www.emacswiki.org/emacs/HighlineMode"
# taken from: http://www.emacswiki.org/emacs/download/${PN}.el
SRC_URI="http://dev.gentoo.org/~ulm/distfiles/${P}.el.xz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 ppc ~s390 x86"

SITEFILE="50${PN}-gentoo.el"

src_compile() {
	elisp-compile *.el
	elisp-make-autoload-file
}
