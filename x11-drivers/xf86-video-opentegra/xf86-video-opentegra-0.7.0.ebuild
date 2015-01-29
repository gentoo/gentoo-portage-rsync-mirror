# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-opentegra/xf86-video-opentegra-0.7.0.ebuild,v 1.1 2015/01/29 17:04:48 chithanh Exp $

EAPI=5

inherit xorg-2

DESCRIPTION="X.Org video driver for NVIDIA Tegra"

SRC_URI="http://xorg.freedesktop.org/releases/individual/driver/${P}.tar.xz"
KEYWORDS="~arm"
IUSE=""

RDEPEND="x11-libs/libdrm[video_cards_tegra]"
DEPEND="${RDEPEND}"
