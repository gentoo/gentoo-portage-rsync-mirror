# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/tramp/tramp-1.52.ebuild,v 1.6 2014/08/04 18:36:25 armin76 Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Remote shell-based file editing."
PKG_CAT="standard"

EXPERIMENTAL=true

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
KEYWORDS="alpha amd64 ~ppc ~ppc64 sparc x86"

inherit xemacs-packages
