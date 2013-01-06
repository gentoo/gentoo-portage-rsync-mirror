# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/xlib/xlib-1.14.ebuild,v 1.4 2008/04/28 18:40:27 armin76 Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Emacs interface to X server."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
