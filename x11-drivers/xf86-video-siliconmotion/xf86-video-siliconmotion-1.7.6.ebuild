# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-siliconmotion/xf86-video-siliconmotion-1.7.6.ebuild,v 1.5 2012/08/12 03:53:27 mattst88 Exp $

EAPI=4
inherit xorg-2

DESCRIPTION="Silicon Motion video driver"

KEYWORDS="amd64 ~mips x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}"
