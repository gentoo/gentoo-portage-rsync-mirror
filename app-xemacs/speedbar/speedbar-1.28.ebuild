# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/speedbar/speedbar-1.28.ebuild,v 1.4 2007/07/11 02:37:37 mr_bones_ Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Provides a separate frame with convenient references."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
app-xemacs/edebug
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
