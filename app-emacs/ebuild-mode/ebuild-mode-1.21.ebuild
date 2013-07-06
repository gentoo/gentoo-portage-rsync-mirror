# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ebuild-mode/ebuild-mode-1.21.ebuild,v 1.2 2013/07/06 18:32:45 ulm Exp $

EAPI=5

inherit readme.gentoo elisp

MY_PN="gentoo-syntax"
DESCRIPTION="Emacs modes for editing ebuilds and other Gentoo specific files"
HOMEPAGE="http://www.gentoo.org/proj/en/lisp/emacs/"
SRC_URI="mirror://gentoo/${MY_PN}-${PV}.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"

S="${WORKDIR}/${MY_PN}-${PV}"
DOCS="ChangeLog keyword-generation.sh"
ELISP_TEXINFO="${MY_PN}.texi"
SITEFILE="50${MY_PN}-gentoo.el"
DOC_CONTENTS="Some optional features may require installation of additional
	packages, like app-portage/gentoolkit-dev for echangelog."
