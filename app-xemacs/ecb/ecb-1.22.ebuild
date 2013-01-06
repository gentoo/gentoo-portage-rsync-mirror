# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/ecb/ecb-1.22.ebuild,v 1.3 2007/06/03 19:45:30 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Emacs source code browser."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
app-xemacs/semantic
app-xemacs/eieio
app-xemacs/fsf-compat
app-xemacs/edit-utils
app-xemacs/jde
app-xemacs/mail-lib
app-xemacs/eshell
app-xemacs/ediff
app-xemacs/xemacs-devel
app-xemacs/speedbar
app-xemacs/c-support
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
