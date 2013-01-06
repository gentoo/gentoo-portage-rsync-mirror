# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-vmware/xf86-video-vmware-12.0.0.ebuild,v 1.1 2012/03/09 00:05:52 chithanh Exp $

EAPI=4

XORG_DRI=always
inherit xorg-2

DESCRIPTION="VMware SVGA video driver"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libdrm[libkms,video_cards_vmware]"
DEPEND="${RDEPEND}"
