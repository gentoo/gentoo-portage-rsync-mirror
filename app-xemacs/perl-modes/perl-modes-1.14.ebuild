# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/perl-modes/perl-modes-1.14.ebuild,v 1.6 2011/07/22 11:25:02 xarthisius Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Perl support."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
app-xemacs/xemacs-ispell
app-xemacs/ps-print
app-xemacs/edit-utils
app-xemacs/fsf-compat
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
