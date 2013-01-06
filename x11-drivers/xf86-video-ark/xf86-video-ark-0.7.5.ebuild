# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-ark/xf86-video-ark-0.7.5.ebuild,v 1.4 2012/12/28 11:08:43 ago Exp $

EAPI=4

inherit xorg-2

DESCRIPTION="X.Org driver for ark cards"
KEYWORDS="amd64 ia64 x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}
	>=x11-libs/libpciaccess-0.12.901"
