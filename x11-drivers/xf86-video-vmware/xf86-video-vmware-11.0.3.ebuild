# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-vmware/xf86-video-vmware-11.0.3.ebuild,v 1.3 2010/12/25 20:23:38 fauli Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="VMware SVGA video driver"
KEYWORDS="amd64 x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-base/xorg-server
	x11-libs/libdrm[libkms,video_cards_vmware]"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/xextproto
	x11-proto/xineramaproto
	x11-proto/xproto"
