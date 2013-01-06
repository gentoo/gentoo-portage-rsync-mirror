# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-neomagic/xf86-video-neomagic-1.2.7.ebuild,v 1.5 2012/12/28 11:19:36 ago Exp $

EAPI=4
inherit xorg-2

DESCRIPTION="Neomagic video driver"
KEYWORDS="amd64 ia64 x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="<x11-base/xorg-server-1.12.99"
DEPEND="${RDEPEND}"
