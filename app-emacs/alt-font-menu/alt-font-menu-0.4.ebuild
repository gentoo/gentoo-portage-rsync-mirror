# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/alt-font-menu/alt-font-menu-0.4.ebuild,v 1.13 2007/12/18 11:13:23 ulm Exp $

inherit elisp

DESCRIPTION="Alternative (auto generated) font menu for X"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/KahlilHodgson"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el
