# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/dropdown-list/dropdown-list-20090814-r1.ebuild,v 1.1 2009/11/26 23:34:29 ulm Exp $

inherit elisp

DESCRIPTION="Drop-down menu interface"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/dropdown-list.el"
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ELISP_PATCHES="${P}-selection-face.patch"
SITEFILE="50${PN}-gentoo.el"
