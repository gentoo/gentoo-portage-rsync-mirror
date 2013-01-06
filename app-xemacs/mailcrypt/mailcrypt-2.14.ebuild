# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/mailcrypt/mailcrypt-2.14.ebuild,v 1.4 2007/07/11 02:37:37 mr_bones_ Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Support for messaging encryption with PGP."
PKG_CAT="standard"

RDEPEND="app-xemacs/mail-lib
app-xemacs/fsf-compat
app-xemacs/xemacs-base
app-xemacs/cookie
app-xemacs/gnus
app-xemacs/mh-e
app-xemacs/rmail
app-xemacs/vm
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
