# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/mail-lib/mail-lib-1.83.ebuild,v 1.8 2014/08/09 10:46:30 ago Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Fundamental lisp files for providing email support."
PKG_CAT="standard"

EXPERIMENTAL=true

RDEPEND="app-xemacs/xemacs-eterm
app-xemacs/xemacs-base
app-xemacs/fsf-compat
app-xemacs/sh-script
app-xemacs/ecrypto
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
