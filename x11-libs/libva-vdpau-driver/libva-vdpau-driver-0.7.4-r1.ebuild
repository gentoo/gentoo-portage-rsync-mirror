# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libva-vdpau-driver/libva-vdpau-driver-0.7.4-r1.ebuild,v 1.1 2014/02/01 15:24:44 axs Exp $

EAPI=5

AUTOTOOLS_AUTORECONF="yes"
inherit autotools-multilib eutils

DESCRIPTION="VDPAU Backend for Video Acceleration (VA) API"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/vaapi"
SRC_URI="http://www.freedesktop.org/software/vaapi/releases/libva-vdpau-driver/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug opengl"

RDEPEND=">=x11-libs/libva-1.1.0[X,opengl?,${MULTILIB_USEDEP}]
	opengl? ( virtual/opengl[${MULTILIB_USEDEP}] )
	x11-libs/libvdpau[${MULTILIB_USEDEP}]
	!x11-libs/vdpau-video"

DEPEND="${DEPEND}
	virtual/pkgconfig"

DOCS=( NEWS README AUTHORS )

src_prepare() {
	epatch "${FILESDIR}/${P}-glext-missing-definition.patch"
	sed -i 's/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/g' configure.ac || die
	autotools-multilib_src_prepare
}

multilib_src_configure() {
	local myeconfargs=(
		$(use_enable debug)
		$(use_enable opengl glx)
	)
	autotools-utils_src_configure
}
