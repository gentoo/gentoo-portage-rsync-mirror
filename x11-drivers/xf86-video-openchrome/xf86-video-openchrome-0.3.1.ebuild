# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-openchrome/xf86-video-openchrome-0.3.1.ebuild,v 1.3 2012/11/18 12:18:23 ago Exp $

EAPI=4
XORG_DRI="dri"
inherit xorg-2

DESCRIPTION="X.Org driver for VIA/S3G cards"
HOMEPAGE="http://www.openchrome.org"
SRC_URI="http://www.openchrome.org/releases/${P}.tar.bz2"
LICENSE="MIT"

KEYWORDS="amd64 x86"
IUSE="debug viaregtool"

RDEPEND=">=x11-base/xorg-server-1.9"
DEPEND="
	${RDEPEND}
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXv
	x11-libs/libXvMC
	x11-libs/libdrm
"

DOCS=( ChangeLog NEWS README )

pkg_setup() {
	xorg-2_pkg_setup
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable debug)
		$(use_enable debug xv-debug)
		$(use_enable dri)
		$(use_enable viaregtool)
	)
}

pkg_postinst() {
	xorg-2_pkg_postinst

	elog "Supported chipsets:"
	elog "CLE266 (VT3122), KM400/P4M800 (VT3205), K8M800 (VT3204),"
	elog "PM800/PM880/CN400 (VT3259), VM800/CN700/P4M800Pro (VT3314),"
	elog "CX700 (VT3324), P4M890 (VT3327), K8M890 (VT3336),"
	elog "P4M900/VN896 (VT3364), VX800 (VT3353), VX855 (VT3409), VX900"
	elog
	elog "The driver name is 'openchrome', and this is what you need"
	elog "to use in your xorg.conf (and not 'via')."
	elog
	elog "See the ChangeLog and release notes for more information."
}
