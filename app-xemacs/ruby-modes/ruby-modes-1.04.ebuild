# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/ruby-modes/ruby-modes-1.04.ebuild,v 1.8 2012/06/02 14:51:33 aballier Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Ruby support."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
app-xemacs/debug
"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86 ~amd64-fbsd"

inherit xemacs-packages
