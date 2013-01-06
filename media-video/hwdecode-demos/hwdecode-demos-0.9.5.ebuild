# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/hwdecode-demos/hwdecode-demos-0.9.5.ebuild,v 1.3 2012/05/05 08:58:59 jdhore Exp $

EAPI=2

inherit base

DESCRIPTION="Standalone programs showing off various HW acceleration APIs"
HOMEPAGE="http://www.splitted-desktop.com/~gbeauchesne/hwdecode-demos/"
SRC_URI="http://www.splitted-desktop.com/~gbeauchesne/hwdecode-demos/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="opengl vaapi vdpau"

RDEPEND="virtual/ffmpeg
	opengl? ( virtual/opengl virtual/glu )
	vaapi? ( x11-libs/libva )
	vdpau? ( x11-libs/libvdpau )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}/ffmpeg.patch" )

src_configure() {
	econf \
		--disable-crystalhd \
		$(use_enable opengl glx) \
		$(use_enable vaapi) \
		$(use_enable vdpau) \
		--disable-xvba
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc NEWS README
}
