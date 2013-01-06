# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-xineliboutput/vdr-xineliboutput-9999.ebuild,v 1.13 2012/05/05 08:27:15 jdhore Exp $

EAPI=3
GENTOO_VDR_CONDITIONAL=yes

inherit vdr-plugin cvs toolchain-funcs eutils

MY_PV=${PV#*_p}
MY_P=${PN}

DESCRIPTION="Video Disk Recorder Xinelib PlugIn"
HOMEPAGE="http://sourceforge.net/projects/xineliboutput/"

ECVS_SERVER="xineliboutput.cvs.sourceforge.net:/cvsroot/xineliboutput"
ECVS_MODULE="${PN}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS=""
IUSE="caps dbus fbcon jpeg libextractor nls +vdr vdpau +X +xine xinerama"

COMMON_DEPEND="
	vdr? (
		>=media-video/vdr-1.6.0
		libextractor? ( >=media-libs/libextractor-0.5.20 )
		caps? ( sys-libs/libcap )
	)

	xine? (
		|| ( <media-libs/xine-lib-1.2 ( >=media-libs/xine-lib-1.2 virtual/ffmpeg ) )
		fbcon? ( jpeg? ( virtual/jpeg ) )
		X? (
			x11-libs/libX11
			x11-libs/libXext
			x11-libs/libXrender
			xinerama? ( x11-libs/libXinerama )
			dbus? ( dev-libs/dbus-glib dev-libs/glib:2 )
			vdpau? ( x11-libs/libvdpau >=media-libs/xine-lib-1.2 )
			jpeg? ( virtual/jpeg )
		)
	)"

DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	sys-kernel/linux-headers
	nls? ( sys-devel/gettext )
	xine? (
		X? (
			x11-proto/xproto
			x11-libs/libXxf86vm
		)
	)"
RDEPEND="${COMMON_DEPEND}"

S=${WORKDIR}/${MY_P}

VDR_CONFD_FILE="${FILESDIR}/confd-1.0.0_pre6"

pkg_setup() {
	if ! use vdr && ! use xine; then
		die "You either need at least one of these flags: vdr xine"
	fi

	vdr-plugin_pkg_setup

	if use xine; then
		XINE_PLUGIN_DIR=$(pkg-config --variable=plugindir libxine)
		[ -z "${XINE_PLUGIN_DIR}" ] && die "Could not find xine plugin dir"
	fi
}

src_prepare() {
	epatch "${FILESDIR}/${P}-build-system.patch"

	# Allow user patches to be applied without modifyfing the ebuild
	epatch_user

	vdr-plugin_src_prepare

	sed -i -e 's:^\(LOCALEDIR\) .*:\1 = $(DESTDIR)/usr/share/vdr/locale:' \
		-e "s:LIBDIR .*:LIBDIR = ${VDR_PLUGIN_DIR}:" \
		Makefile || die
}

src_configure() {
	local myconf

	if has_version ">=media-libs/xine-lib-1.2"; then
		myconf="${myconf} --enable-libavutil"
	else
		myconf="${myconf} --disable-libavutil"
	fi

	# No autotools based configure script
	# There is no real opengl support, just the switch and some help text is
	# left...
	./configure \
		--cc=$(tc-getCC) \
		--cxx=$(tc-getCXX) \
		$(use_enable X x11) \
		$(use_enable X xshm) \
		$(use_enable X xdpms) \
		$(use_enable X xshape) \
		$(use_enable X xrender) \
		$(use_enable fbcon fb) \
		$(use_enable vdr) \
		$(use_enable xine libxine) \
		$(use_enable libextractor) \
		$(use_enable caps libcap) \
		$(use_enable jpeg libjpeg) \
		$(use_enable xinerama) \
		$(use_enable vdpau) \
		$(use_enable dbus dbus-glib-1) \
		$(use_enable nls i18n) \
		${myconf} \
		--disable-opengl \
		|| die
}

src_install() {
	if use vdr; then
		vdr-plugin_src_install

		# bug 346989
		insinto /etc/vdr/plugins/xineliboutput/
		doins examples/allowed_hosts.conf || die
		fowners -R vdr:vdr /etc/vdr/

		if use nls; then
			emake DESTDIR="${D}" i18n || die
		fi

		if use xine; then
			insinto $XINE_PLUGIN_DIR
			doins xineplug_inp_xvdr.so || die

			insinto $XINE_PLUGIN_DIR/post
			doins xineplug_post_*.so || die

			if use fbcon; then
				dobin vdr-fbfe || die

				insinto $VDR_PLUGIN_DIR
				doins libxineliboutput-fbfe.so.* || die
			fi

			if use X; then
				dobin vdr-sxfe || die

				insinto $VDR_PLUGIN_DIR
				doins libxineliboutput-sxfe.so.* || die
			fi
		fi
	else
		emake DESTDIR="${D}" install || die

		dodoc HISTORY README
	fi
}
