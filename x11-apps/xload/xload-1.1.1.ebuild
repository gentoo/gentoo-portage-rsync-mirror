# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xload/xload-1.1.1.ebuild,v 1.8 2012/08/26 16:56:41 armin76 Exp $

EAPI=4

inherit xorg-2

DESCRIPTION="system load average display for X"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="x11-libs/libXaw
	x11-libs/libXmu
	x11-libs/libXt
	x11-libs/libX11"
DEPEND="${RDEPEND}
	sys-devel/gettext"
