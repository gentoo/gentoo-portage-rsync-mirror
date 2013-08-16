# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-neomagic/xf86-video-neomagic-1.2.8.ebuild,v 1.2 2013/08/16 19:00:13 chithanh Exp $

EAPI=5
inherit xorg-2

DESCRIPTION="Neomagic video driver"
KEYWORDS="amd64 ia64 x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="<x11-base/xorg-server-1.12.99"
DEPEND="${RDEPEND}"
