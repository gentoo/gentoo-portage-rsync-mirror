# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/cc-mode/cc-mode-1.45.ebuild,v 1.3 2007/06/03 17:50:32 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="C, C++ and Java language support."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
app-xemacs/mail-lib
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
