# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xman/xman-1.1.2.ebuild,v 1.7 2012/02/19 14:34:23 armin76 Exp $

EAPI=4
inherit xorg-2

DESCRIPTION="Manual page display program for the X Window System"

KEYWORDS="amd64 arm hppa ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="x11-libs/libXaw
	x11-libs/libXt
	x11-libs/libXmu
	x11-proto/xproto"
DEPEND="${RDEPEND}"
