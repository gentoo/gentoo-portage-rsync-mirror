# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/thinks/thinks-1.9.ebuild,v 1.1 2009/10/15 19:32:28 ulm Exp $

inherit elisp

DESCRIPTION="Insert text in a think bubble"
HOMEPAGE="http://www.davep.org/emacs/"
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 x86"
IUSE=""

SITEFILE="50${PN}-gentoo.el"
