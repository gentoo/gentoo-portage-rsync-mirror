# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/pager/pager-1.1-r2.ebuild,v 1.7 2012/05/03 04:40:44 jdhore Exp $

EAPI="1"

ROX_CLIB_VER="2.1.9-r2"
inherit rox-0install

DESCRIPTION="Pager - A pager applet for ROX-Filer"
HOMEPAGE="http://rox.sourceforge.net/"
SRC_URI="mirror://sourceforge/rox/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 sparc x86"
IUSE=""

RDEPEND=">=x11-libs/libwnck-2.4.0:1"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

APPNAME=Pager
APPNAME_COLLISION=True
ZEROINSTALL_STRIP_REQUIRES=True
