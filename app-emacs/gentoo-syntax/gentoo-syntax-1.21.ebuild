# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/gentoo-syntax/gentoo-syntax-1.21.ebuild,v 1.10 2013/05/25 08:02:40 ago Exp $

EAPI=5

inherit readme.gentoo elisp

DESCRIPTION="Emacs modes for editing ebuilds and other Gentoo specific files"
HOMEPAGE="http://www.gentoo.org/proj/en/lisp/emacs/"
SRC_URI="mirror://gentoo/${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"

DOCS="ChangeLog keyword-generation.sh"
ELISP_TEXINFO="${PN}.texi"
SITEFILE="50${PN}-gentoo.el"
DOC_CONTENTS="Some optional features may require installation of additional
	packages, like app-portage/gentoolkit-dev for echangelog."
