# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/igrep/igrep-1.14.ebuild,v 1.4 2007/07/11 02:37:37 mr_bones_ Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Enhanced front-end for Grep."
PKG_CAT="standard"

RDEPEND="app-xemacs/dired
app-xemacs/xemacs-base
app-xemacs/efs
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
