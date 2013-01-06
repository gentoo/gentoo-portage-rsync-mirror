# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/protbuf/protbuf-1.7-r1.ebuild,v 1.2 2007/12/02 14:07:50 opfer Exp $

inherit elisp

DESCRIPTION="Protect Emacs buffers from accidental killing"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki.pl?ProtectingBuffers"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

SITEFILE=51${PN}-gentoo.el
