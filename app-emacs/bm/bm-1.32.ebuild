# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/bm/bm-1.32.ebuild,v 1.4 2008/06/14 23:21:35 ulm Exp $

inherit elisp

DESCRIPTION="Visible bookmarks in buffer"
HOMEPAGE="http://www.nongnu.org/bm/"
# taken from http://download.savannah.gnu.org/releases/bm/${P}.el
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el
