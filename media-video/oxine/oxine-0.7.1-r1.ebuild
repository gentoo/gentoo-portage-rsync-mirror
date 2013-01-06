# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/oxine/oxine-0.7.1-r1.ebuild,v 1.3 2012/05/05 08:58:50 jdhore Exp $

WANT_AUTOMAKE="1.9"
inherit eutils autotools

DESCRIPTION="OSD frontend for Xine"
HOMEPAGE="http://oxine.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ~ppc64 x86"
SLOT="0"
IUSE="X curl debug dvb exif joystick jpeg lirc nls png v4l"

COMMON_DEPEND="media-libs/xine-lib
	dev-libs/libcdio
	curl? ( net-misc/curl )
	joystick? ( media-libs/libjsw )
	jpeg? ( media-gfx/imagemagick
		media-libs/netpbm
		media-video/mjpegtools )
	lirc? ( app-misc/lirc )
	nls? ( virtual/libintl
		sys-devel/gettext )
	png? ( media-gfx/imagemagick
		media-libs/netpbm
		media-video/mjpegtools )
	X? ( x11-libs/libXext
		x11-libs/libX11 )"
RDEPEND="${COMMON_DEPEND}
	virtual/eject"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"

pkg_setup() {

	# Video4Linux support
	if ( use dvb || use v4l ) && ! built_with_use media-libs/xine-lib v4l ; then
		eerror "Re-emerge xine-lib with the 'v4l' USE flag"
		REBUILD_DEPS=1
	fi

	# X
	if ! built_with_use media-libs/xine-lib X ; then
		eerror "Re-emerge xine-lib with the 'X' USE flag"
		REBUILD_DEPS=1
	fi

	# Image support
	if (use png || use jpeg ) && ! built_with_use media-libs/netpbm zlib ; then
		eerror "In order to enable image support, media-libs/netpbm must be"
		eerror "emerged with the 'zlib' USE flag"
		REBUILD_DEPS=1
	fi

	if (use png || use jpeg ) && ! built_with_use media-libs/netpbm png ; then
		eerror "To view PNG images, media-libs/netpbm must be emerged with"
		eerror "the 'png' USE flag"
		REBUILD_DEPS=1
	fi

	if (use png || use jpeg ) && ! built_with_use media-libs/netpbm jpeg ; then
		eerror "To view JPEG images, media-libs/netpbm must be emerged with"
		eerror "with the 'jpeg' USE flag"
		REBUILD_DEPS=1
	fi

	if ! built_with_use media-libs/xine-lib imagemagick ; then
		eerror "To display its menus, oxine needs xine-lib to be compiled"
		eerror "with with the 'imagemagick' USE flag"
		REBUILD_DEPS=1
	fi

	if [[ ${REBUILD_DEPS} = 1 ]]; then
		eerror "Check your USE flags, re-emerge the dependencies and then"
		eerror "emerge this package."
		die
	fi

}

src_compile() {

	# Note on images: Image support will be automatically disabled if
	# netpbm, imagemagick or mjpegtools is not installed, irregardless
	# of what the USE flags are set to.

	# If one of the image USE flags is unset, disable image support
	if use !png && use !jpeg ; then
		myconf="${myconf} --disable-images"
	fi

	econf ${myconf} \
		$( use_with X x ) \
		$( use_with curl ) \
		$( use_enable debug ) \
		$( use_enable dvb ) \
		$( use_enable exif ) \
		--disable-hal \
		$( use_enable joystick ) \
		$( use_enable lirc ) \
		$( use_enable nls ) \
		$( use_enable v4l ) \
		--disable-extractor \
		--disable-rpath || die "econf died"
	emake || die "emake failed"
}

src_install() {

	emake DESTDIR="${D}" install || die "emake install died"

	dodoc AUTHORS ChangeLog NEWS README TODO
	dohtml doc/README.html doc/keymapping.pdf

}
