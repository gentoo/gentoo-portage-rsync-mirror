# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/apel/apel-1.32.ebuild,v 1.5 2007/06/03 17:44:49 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="A Portable Emacs Library.  Used by XEmacs MIME support."
PKG_CAT="standard"

RDEPEND="app-xemacs/fsf-compat
app-xemacs/xemacs-base
"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86"

inherit xemacs-packages
