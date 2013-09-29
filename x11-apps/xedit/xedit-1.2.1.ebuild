# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xedit/xedit-1.2.1.ebuild,v 1.2 2013/09/29 11:09:04 ago Exp $

EAPI=5

inherit xorg-2

DESCRIPTION="simple text editor for X"
KEYWORDS="amd64 ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/libXaw
	x11-libs/libXt
	x11-libs/libXmu
	x11-libs/libX11"
DEPEND="${RDEPEND}"
