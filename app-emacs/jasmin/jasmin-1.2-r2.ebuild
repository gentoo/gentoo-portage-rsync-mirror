# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/jasmin/jasmin-1.2-r2.ebuild,v 1.1 2013/12/29 14:22:35 ulm Exp $

EAPI=5

inherit elisp

DESCRIPTION="An Emacs major mode for editing Jasmin Java bytecode assembler files"
HOMEPAGE="http://www.neilvandyke.org/jasmin-emacs/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~s390 ~x86"

SITEFILE="50${PN}-gentoo.el"
