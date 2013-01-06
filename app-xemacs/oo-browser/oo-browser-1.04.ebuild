# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/oo-browser/oo-browser-1.04.ebuild,v 1.4 2008/04/28 18:03:57 armin76 Exp $

SLOT="0"
IUSE=""
DESCRIPTION="The Multi-Language Object-Oriented Code Browser."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
app-xemacs/hyperbole
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
