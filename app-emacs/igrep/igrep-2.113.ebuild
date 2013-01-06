# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/igrep/igrep-2.113.ebuild,v 1.3 2007/11/06 09:07:39 opfer Exp $

inherit elisp

DESCRIPTION='An improved interface to "grep" and "find"'
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/GrepMode"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el
