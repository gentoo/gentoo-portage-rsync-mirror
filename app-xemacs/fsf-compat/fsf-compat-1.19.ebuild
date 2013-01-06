# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/fsf-compat/fsf-compat-1.19.ebuild,v 1.8 2012/06/02 14:11:32 aballier Exp $

SLOT="0"
IUSE=""
DESCRIPTION="FSF Emacs compatibility files."
PKG_CAT="standard"

KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86 ~amd64-fbsd"

inherit xemacs-packages

RDEPEND="app-xemacs/xemacs-base
"
