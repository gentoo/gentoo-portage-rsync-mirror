# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/crypt++/crypt++-2.94_pre20080430.ebuild,v 1.2 2008/06/14 23:23:47 ulm Exp $

inherit elisp

DESCRIPTION="Handle all sorts of compressed and encrypted files"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/CryptPlusPlus
	http://freshmeat.net/projects/crypt/"
# snapshot from http://cvs.xemacs.org/viewcvs.cgi/XEmacs/packages/xemacs-packages/os-utils/crypt.el
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el
