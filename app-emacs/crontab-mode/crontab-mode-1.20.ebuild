# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/crontab-mode/crontab-mode-1.20.ebuild,v 1.4 2007/12/13 08:10:23 opfer Exp $

inherit elisp

DESCRIPTION="Mode for editing crontab files"
HOMEPAGE="http://www.mahalito.net/~harley/elisp/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el
