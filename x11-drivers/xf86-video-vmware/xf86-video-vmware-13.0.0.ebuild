# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-vmware/xf86-video-vmware-13.0.0.ebuild,v 1.1 2013/01/20 18:53:56 chithanh Exp $

EAPI=5

XORG_DRI=always
inherit xorg-2

DESCRIPTION="VMware SVGA video driver"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libdrm[libkms,video_cards_vmware]
	media-libs/mesa[xa]"
DEPEND="${RDEPEND}"
