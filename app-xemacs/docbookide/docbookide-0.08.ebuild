# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/docbookide/docbookide-0.08.ebuild,v 1.8 2008/05/12 13:53:29 corsair Exp $

SLOT="0"
IUSE=""
DESCRIPTION="DocBook editing support."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
app-xemacs/xemacs-ispell
app-xemacs/mail-lib
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
