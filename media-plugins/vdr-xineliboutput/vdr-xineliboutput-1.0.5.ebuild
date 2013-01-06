# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-xineliboutput/vdr-xineliboutput-1.0.5.ebuild,v 1.3 2012/04/13 19:31:39 ulm Exp $

EAPI=2
GENTOO_VDR_CONDITIONAL=yes

inherit vdr-plugin eutils multilib versionator

MY_PV=${PV#*_p}
MY_P=${PN}-cvs-${MY_PV}

DESCRIPTION="Video Disk Recorder Xinelib PlugIn"
HOMEPAGE="http://sourceforge.net/projects/xineliboutput/"
SRC_URI="mirror://sourceforge/${PN#vdr-}/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="+vdr +xine fbcon X libextractor xinerama"

# both vdr plugin or vdr-sxfe can use X11
# still depends need some cleanup
COMMON_DEPEND="
	vdr? ( >=media-video/vdr-1.4.0 )

	xine? ( >=media-libs/xine-lib-1.1.1 )

	virtual/jpeg
	libextractor? ( >=media-libs/libextractor-0.5.20 )

	X? (
		x11-libs/libX11
		x11-libs/libXv
		x11-libs/libXext
		x11-libs/libXrender
		xinerama? ( x11-libs/libXinerama )
	)"

DEPEND="${COMMON_DEPEND}
	sys-kernel/linux-headers
	X? (
		x11-proto/xextproto
		x11-proto/xf86vidmodeproto
		x11-proto/xproto
		x11-proto/renderproto
		xinerama? ( x11-proto/xineramaproto )
	)"

RDEPEND="${COMMON_DEPEND}"

#S=${WORKDIR}/${MY_P#vdr-}

VDR_CONFD_FILE=${FILESDIR}/confd-1.0.0_pre6

pkg_setup() {
	vdr-plugin_pkg_setup

	if ! use vdr && ! use xine; then
		eerror "Compiling ${PN} with USE='-vdr -xine' is not possible."
		eerror "You either need at least one of these flags."
		#die "${PN} cannot be used with vdr support and xine support disabled!"
	fi
}

use_onoff() {
	if use "$1"; then
		echo 1
	else
		echo 0
	fi
}

use_onoff_xine() {
	if use xine && use "$1"; then
		echo 1
	else
		echo 0
	fi
}

src_prepare() {
	vdr-plugin_src_prepare

	if use xine; then
		XINE_PLUGIN_DIR=$(xine-config --plugindir)
		if [[ ${XINE_PLUGIN_DIR} = "" ]]; then
			eerror "Could not find xine plugin dir"
			die "Could not find xine plugin dir"
		fi
	fi

	# stop some automagic overwriting of the stuff we set
	sed -e '/XINELIBOUTPUT_VDRPLUGIN = 1/s/^/#/' \
		-e '/HAVE_EXTRACTOR_H = 1/s/^/#/' \
		-i Makefile

	cat >>Make.config <<-EOF
		XINELIBOUTPUT_XINEPLUGIN = $(use_onoff xine)
		XINELIBOUTPUT_VDRPLUGIN = $(use_onoff vdr)

		XINELIBOUTPUT_FB = $(use_onoff_xine fbcon)
		XINELIBOUTPUT_X11 = $(use_onoff_xine X)

		HAVE_XRENDER = 1
		HAVE_XDPMS = 1
		HAVE_EXTRACTOR_H = $(use_onoff libextractor)
		HAVE_XINERAMA = $(use_onoff xinerama)
	EOF

	# patching makefile to work with this
	# $ rm ${outdir}/file; cp file ${outdir}/file
	# work in the sandbox
	sed -i Makefile \
		-e 's:XINEPLUGINDIR.*=.*:XINEPLUGINDIR = '"${WORKDIR}/lib:" \
		-e 's:VDRINCDIR.*=.*:VDRINCDIR ?= /usr/include:'
	mkdir -p "${WORKDIR}/lib"
}

src_configure() { :; }

src_install() {
	if use vdr; then
		# install vdr plugin
		vdr-plugin_src_install

		# version number that the sources contain
		local SO_VERSION="$(grep 'static const char \*VERSION *=' xineliboutput.c |\
						cut	-d'"' -f2)"
	echo SO_VERSION=$SO_VERSION
		insinto ${VDR_PLUGIN_DIR}
		if use fbcon; then
			doins libxineliboutput-fbfe.so.${SO_VERSION} || die "doins failed"
		fi
		if use X; then
			doins libxineliboutput-sxfe.so.${SO_VERSION} || die "doins failed"
		fi
	fi

	if use xine; then
		# install xine-plugins
		insinto "${XINE_PLUGIN_DIR}"
		doins xineplug_inp_*.so

		insinto "${XINE_PLUGIN_DIR}"/post
		doins xineplug_post_*.so

		# install xine-based frontends
		use fbcon && dobin vdr-fbfe
		use X && dobin vdr-sxfe

	fi
}

pkg_config() {
	einfo "emerge --config is not supported"
}
