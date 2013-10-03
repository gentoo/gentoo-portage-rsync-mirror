# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/showfont/showfont-1.0.4.ebuild,v 1.3 2013/10/03 20:06:01 ago Exp $

EAPI=5

inherit xorg-2

DESCRIPTION="font dumper for X font server"
KEYWORDS="amd64 ~arm ~mips ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/libFS"
DEPEND="${RDEPEND}"
