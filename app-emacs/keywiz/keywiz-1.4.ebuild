# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/keywiz/keywiz-1.4.ebuild,v 1.6 2007/12/14 05:19:54 opfer Exp $

inherit elisp eutils

DESCRIPTION="Emacs key sequence quiz"
HOMEPAGE="http://www.phys.au.dk/~harder/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

SITEFILE=50keywiz-gentoo.el
