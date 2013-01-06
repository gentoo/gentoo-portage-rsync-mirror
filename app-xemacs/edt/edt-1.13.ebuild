# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/edt/edt-1.13.ebuild,v 1.3 2007/06/03 18:13:08 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="DEC EDIT/EDT emulation."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
