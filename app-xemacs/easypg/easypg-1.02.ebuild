# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/easypg/easypg-1.02.ebuild,v 1.1 2009/07/26 07:10:24 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="GnuPG interface for Emacs."
PKG_CAT="standard"

KEYWORDS="~amd64"

RDEPEND="app-xemacs/xemacs-base
	app-xemacs/dired
	app-xemacs/mail-lib"

inherit xemacs-packages
