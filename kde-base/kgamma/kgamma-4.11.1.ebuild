# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kgamma/kgamma-4.11.1.ebuild,v 1.1 2013/09/03 19:04:14 creffett Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE screen gamma values kcontrol module"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	x11-libs/libXxf86vm
"
DEPEND="${RDEPEND}
	x11-proto/xf86vidmodeproto
"
