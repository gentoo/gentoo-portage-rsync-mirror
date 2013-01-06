# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/build/build-1.15.ebuild,v 1.6 2011/07/22 11:24:58 xarthisius Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Build XEmacs from within (UNIX, Windows)."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
app-xemacs/pcl-cvs
app-xemacs/dired
app-xemacs/w3
app-xemacs/prog-modes
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
