# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xstdcmap/xstdcmap-1.0.3.ebuild,v 1.5 2013/10/04 11:59:59 ago Exp $

EAPI=5

inherit xorg-2

DESCRIPTION="X standard colormap utility"
KEYWORDS="amd64 ~arm hppa ~mips ppc ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""
RDEPEND="x11-libs/libXmu
	x11-libs/libX11"
DEPEND="${RDEPEND}"
