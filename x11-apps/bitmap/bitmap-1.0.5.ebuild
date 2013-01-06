# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/bitmap/bitmap-1.0.5.ebuild,v 1.9 2011/02/14 23:41:02 xarthisius Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="X.Org bitmap application"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""
RDEPEND="x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libXaw
	x11-libs/libXt
	x11-misc/xbitmaps"
DEPEND="${RDEPEND}"
