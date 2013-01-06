# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/stk11xx/stk11xx-2.1.0.ebuild,v 1.3 2011/02/04 23:39:36 mgorny Exp $

EAPI=2

inherit base linux-mod

DESCRIPTION="A driver for Syntek webcams often found in Asus notebooks"
HOMEPAGE="http://syntekdriver.sourceforge.net/"
SRC_URI="mirror://sourceforge/syntekdriver/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

MODULE_NAMES="${PN}(media/video:)"
CONFIG_CHECK="VIDEO_DEV VIDEO_V4L1_COMPAT"

pkg_setup() {
	linux-mod_pkg_setup

	BUILD_TARGETS="${PN}.ko"
	BUILD_PARAMS="-C ${KV_DIR} SUBDIRS=${S}"

	PATCHES=(
		"${FILESDIR}"/${PN}-v4l_compat_ioctl32.diff
		# http://sourceforge.net/tracker/index.php?func=detail&aid=3152597&group_id=178178&atid=884193
		"${FILESDIR}"/${PN}-2.6.37.patch
	)
	MODULESD_STK11XX_DOCS=( README )
}
