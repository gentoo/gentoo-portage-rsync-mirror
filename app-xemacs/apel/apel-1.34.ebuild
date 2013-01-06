# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/apel/apel-1.34.ebuild,v 1.8 2012/06/02 14:11:30 aballier Exp $

SLOT="0"
IUSE=""
DESCRIPTION="A Portable Emacs Library.  Used by XEmacs MIME support."
PKG_CAT="standard"

RDEPEND="app-xemacs/fsf-compat
app-xemacs/xemacs-base
"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86 ~amd64-fbsd"

inherit xemacs-packages
