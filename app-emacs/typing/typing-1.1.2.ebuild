# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/typing/typing-1.1.2.ebuild,v 1.12 2007/11/04 17:05:47 ulm Exp $

inherit elisp

DESCRIPTION='The Typing of Emacs -- an Elisp parody of The Typing of the Dead for Dreamcast'
HOMEPAGE="ftp://ftp.cis.ohio-state.edu/pub/emacs-lisp/archive/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc64 x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el
