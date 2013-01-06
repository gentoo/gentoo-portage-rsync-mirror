# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xgc/xgc-1.0.3.ebuild,v 1.8 2011/02/14 23:40:56 xarthisius Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="X graphics demo"
KEYWORDS="amd64 arm hppa ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="x11-libs/libXaw
	x11-libs/libXt"
DEPEND="${RDEPEND}"
