# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libxshmfence/libxshmfence-1.0.ebuild,v 1.1 2013/11/01 03:11:26 mattst88 Exp $

EAPI=5
XORG_EAUTORECONF=yes
inherit xorg-2

DESCRIPTION="Shared memory fences using futexes"

KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
