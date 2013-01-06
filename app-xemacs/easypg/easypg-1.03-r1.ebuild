# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/easypg/easypg-1.03-r1.ebuild,v 1.7 2011/07/22 11:24:58 xarthisius Exp $

PKG_CAT="standard"

inherit xemacs-packages

SLOT="0"
IUSE=""
DESCRIPTION="GnuPG interface for Emacs."

KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

RDEPEND="app-xemacs/xemacs-base
app-xemacs/dired
app-xemacs/mail-lib
"
