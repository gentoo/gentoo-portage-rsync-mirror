# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/erobot/erobot-2.1.0-r1.ebuild,v 1.5 2009/12/15 17:31:25 ulm Exp $

inherit elisp

DESCRIPTION="Battle-bots for Emacs!"
HOMEPAGE="http://www.emacswiki.org/emacs/EmacsRobots"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

ELISP_PATCHES="${P}-fix-interactive.patch"
SITEFILE="50${PN}-gentoo.el"
