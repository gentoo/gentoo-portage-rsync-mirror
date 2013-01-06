# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/fonttosfnt/fonttosfnt-1.0.4.ebuild,v 1.10 2010/01/19 18:12:31 armin76 Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org fonttosfnt application"
KEYWORDS="amd64 arm ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""
RDEPEND="x11-libs/libX11
	=media-libs/freetype-2*
	x11-libs/libfontenc"
DEPEND="${RDEPEND}"
