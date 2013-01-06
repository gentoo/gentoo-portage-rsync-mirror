# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/vhdl/vhdl-1.22.ebuild,v 1.4 2007/07/11 02:37:37 mr_bones_ Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Support for VHDL."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
app-xemacs/edit-utils
app-xemacs/c-support
app-xemacs/speedbar
app-xemacs/ps-print
app-xemacs/os-utils
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
