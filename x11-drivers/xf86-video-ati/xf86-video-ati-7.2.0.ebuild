# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-ati/xf86-video-ati-7.2.0.ebuild,v 1.2 2013/09/29 11:12:18 ago Exp $

EAPI=5

XORG_DRI=always
inherit linux-info xorg-2

DESCRIPTION="ATI video driver"

KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="glamor udev"

RDEPEND=">=x11-libs/libdrm-2.4.46[video_cards_radeon]
	glamor? ( x11-libs/glamor )
	udev? ( virtual/udev )"
DEPEND="${RDEPEND}"

pkg_pretend() {
	if use kernel_linux ; then
		if kernel_is -ge 3 9; then
			CONFIG_CHECK="~!DRM_RADEON_UMS ~!FB_RADEON"
		else
			CONFIG_CHECK="~DRM_RADEON_KMS ~!FB_RADEON"
		fi
	fi
	check_extra_config
}

src_configure() {
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable glamor)
		$(use_enable udev)
	)
	xorg-2_src_configure
}
