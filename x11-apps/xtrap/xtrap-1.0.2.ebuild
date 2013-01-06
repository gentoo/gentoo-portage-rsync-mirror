# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xtrap/xtrap-1.0.2.ebuild,v 1.9 2010/01/17 22:56:14 jer Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xtrap application"
KEYWORDS="amd64 arm hppa ~mips ppc ppc64 s390 sh ~sparc x86"
IUSE=""
RDEPEND="x11-libs/libX11
	x11-libs/libXTrap"
DEPEND="${RDEPEND}
	x11-proto/trapproto"
