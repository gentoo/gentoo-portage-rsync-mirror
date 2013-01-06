# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-nouveau/xf86-video-nouveau-1.0.4.ebuild,v 1.5 2012/12/08 17:11:24 ago Exp $

EAPI=4
XORG_DRI="always"
inherit xorg-2

DESCRIPTION="Accelerated Open Source driver for nVidia cards"
HOMEPAGE="http://nouveau.freedesktop.org/"

KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

RDEPEND=">=x11-libs/libdrm-2.4.34[video_cards_nouveau]"
DEPEND="${RDEPEND}
	x11-proto/glproto
	x11-proto/xf86driproto
	x11-proto/dri2proto"
