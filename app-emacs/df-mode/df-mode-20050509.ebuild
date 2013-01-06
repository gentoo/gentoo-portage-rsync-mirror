# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/df-mode/df-mode-20050509.ebuild,v 1.6 2011/11/11 21:51:34 ulm Exp $

EAPI=4

inherit elisp

DESCRIPTION="Minor mode to show space left on devices in the mode line"
HOMEPAGE="http://www.coli.uni-saarland.de/~fouvry/software.html
	http://www.emacswiki.org/cgi-bin/wiki/DfMode"
# taken from http://www.coli.uni-saarland.de/~fouvry/files/df-mode.el.gz
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

SITEFILE="50${PN}-gentoo.el"
