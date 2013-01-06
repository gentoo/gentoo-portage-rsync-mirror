# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/http-emacs/http-emacs-1.1-r1.ebuild,v 1.3 2011/12/09 00:40:08 ulm Exp $

inherit elisp

DESCRIPTION="Fetch, render and post html pages and edit wiki pages via Emacs"
HOMEPAGE="http://emacswiki.org/cgi-bin/wiki.pl?SimpleWikiEditMode"
SRC_URI="http://savannah.nongnu.org/download/http-emacs/http-emacs.pkg/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE=""

S="${WORKDIR}/${PN}"
DOCS="CONTRIBUTORS"
SITEFILE="50${PN}-gentoo.el"
