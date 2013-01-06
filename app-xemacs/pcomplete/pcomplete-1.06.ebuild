# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/pcomplete/pcomplete-1.06.ebuild,v 1.6 2011/07/22 11:25:02 xarthisius Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Provides programmatic completion."
PKG_CAT="standard"

RDEPEND="app-xemacs/sh-script
app-xemacs/xemacs-base
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
