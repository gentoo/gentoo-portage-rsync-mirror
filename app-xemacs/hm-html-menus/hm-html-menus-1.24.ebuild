# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/hm-html-menus/hm-html-menus-1.24.ebuild,v 1.6 2011/07/22 11:25:08 xarthisius Exp $

SLOT="0"
IUSE=""
DESCRIPTION="HTML editing."
SRC_URI="http://ftp.xemacs.org/packages/hm--html-menus-${PV}-pkg.tar.gz"
PKG_CAT="standard"

RDEPEND="app-xemacs/dired
app-xemacs/xemacs-base
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
