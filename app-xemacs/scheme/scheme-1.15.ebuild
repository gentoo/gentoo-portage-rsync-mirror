# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/scheme/scheme-1.15.ebuild,v 1.8 2008/05/12 14:03:55 corsair Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Front-end support for Inferior Scheme."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
