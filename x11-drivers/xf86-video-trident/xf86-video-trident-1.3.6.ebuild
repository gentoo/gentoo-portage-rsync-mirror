# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-trident/xf86-video-trident-1.3.6.ebuild,v 1.4 2012/11/28 21:43:02 ranger Exp $

EAPI=4
inherit xorg-2

DESCRIPTION="Trident video driver"
KEYWORDS="amd64 ~ia64 ppc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}"
