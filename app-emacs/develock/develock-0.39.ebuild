# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/develock/develock-0.39.ebuild,v 1.5 2009/12/26 17:47:00 armin76 Exp $

inherit elisp

DESCRIPTION="An Emacs minor mode for highlighting broken formatting rules"
HOMEPAGE="http://www.jpl.org/ftp/pub/elisp/"
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

SITEFILE="50${PN}-gentoo.el"
