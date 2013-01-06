# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ssh/ssh-1.9.ebuild,v 1.1 2006/03/06 17:15:24 mkennedy Exp $

inherit elisp

DESCRIPTION="Directory tracking and special character handling support for SSH sessions in Emacs shell buffers."
HOMEPAGE="http://www.splode.com/~friedman/software/emacs-lisp/index.html#ssh"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~sparc"
IUSE=""

SITEFILE=50ssh-gentoo.el
