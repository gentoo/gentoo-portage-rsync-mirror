# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/elib/elib-1.13.ebuild,v 1.6 2011/07/22 11:25:05 xarthisius Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Portable Emacs Lisp utilities library."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
