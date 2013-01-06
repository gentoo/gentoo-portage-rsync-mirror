# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/stripes/stripes-0.2-r1.ebuild,v 1.4 2007/10/18 21:30:28 ulm Exp $

inherit elisp

DESCRIPTION="Stripes is an Emacs mode which highlights every even line with an alternative background color"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/StripesMode"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 x86"
IUSE=""

SITEFILE=51${PN}-gentoo.el
