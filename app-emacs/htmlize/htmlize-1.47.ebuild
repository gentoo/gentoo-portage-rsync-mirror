# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/htmlize/htmlize-1.47.ebuild,v 1.2 2014/03/31 14:01:01 nimiux Exp $

EAPI=5

inherit elisp

DESCRIPTION="HTML-ize font-lock buffers in Emacs"
HOMEPAGE="http://emacswiki.org/emacs/Htmlize
	http://fly.srk.fer.hr/~hniksic/emacs/"
SRC_URI="http://dev.gentoo.org/~ulm/distfiles/${P}.el.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"

SITEFILE="50${PN}-gentoo.el"
