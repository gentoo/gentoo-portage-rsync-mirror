# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/uboat/uboat-1.2.ebuild,v 1.14 2008/01/25 00:58:28 ulm Exp $

inherit elisp

DESCRIPTION="Generate u-boat-death messages, patterned after Iron Coffins"
HOMEPAGE="http://www.splode.com/~friedman/software/emacs-lisp/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

# Noah Friedman and Bob Manson have confirmed that this is in the public domain
LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el
