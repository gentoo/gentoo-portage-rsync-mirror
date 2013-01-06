# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/ess/ess-1.03.ebuild,v 1.8 2007/06/03 18:24:10 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="ESS: Emacs Speaks Statistics."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/mail-lib
app-xemacs/fsf-compat
app-xemacs/edit-utils
app-xemacs/speedbar
app-xemacs/sh-script
app-xemacs/xemacs-eterm
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
