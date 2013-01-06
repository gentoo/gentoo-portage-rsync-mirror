# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/mule-ucs/mule-ucs-1.18.ebuild,v 1.6 2011/07/22 11:24:58 xarthisius Exp $

SLOT="0"
IUSE=""
DESCRIPTION="MULE: Extended coding systems (including Unicode) for XEmacs."
PKG_CAT="mule"

RDEPEND="app-xemacs/mule-base
app-xemacs/latin-euro-standards
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
