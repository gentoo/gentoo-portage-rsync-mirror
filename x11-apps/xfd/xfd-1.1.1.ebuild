# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xfd/xfd-1.1.1.ebuild,v 1.8 2012/08/26 16:43:22 armin76 Exp $

EAPI=4

inherit xorg-2

DESCRIPTION="X.Org xfd application"
KEYWORDS="amd64 arm hppa ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="media-libs/freetype:2
	media-libs/fontconfig
	x11-libs/libXft
	x11-libs/libXt
	x11-libs/libXmu
	x11-libs/libXrender
	x11-libs/libXaw"
DEPEND="${RDEPEND}
	sys-devel/gettext"
