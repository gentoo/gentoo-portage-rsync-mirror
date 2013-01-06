# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/edebug/edebug-1.22.ebuild,v 1.3 2007/06/03 18:08:10 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="An Emacs Lisp debugger."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
app-xemacs/xemacs-devel
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
