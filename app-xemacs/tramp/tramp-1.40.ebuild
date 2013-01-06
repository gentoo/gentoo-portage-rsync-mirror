# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/tramp/tramp-1.40.ebuild,v 1.6 2011/07/22 11:25:04 xarthisius Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Remote shell-based file editing."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
app-xemacs/vc
app-xemacs/efs
app-xemacs/dired
app-xemacs/mail-lib
app-xemacs/gnus
app-xemacs/ediff
app-xemacs/sh-script
app-xemacs/edebug
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
