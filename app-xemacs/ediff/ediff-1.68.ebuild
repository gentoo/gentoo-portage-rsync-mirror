# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/ediff/ediff-1.68.ebuild,v 1.6 2008/05/12 13:54:43 corsair Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Interface over GNU patch."
PKG_CAT="standard"

RDEPEND="app-xemacs/pcl-cvs
app-xemacs/elib
app-xemacs/dired
app-xemacs/xemacs-base
app-xemacs/edebug
app-xemacs/prog-modes
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
