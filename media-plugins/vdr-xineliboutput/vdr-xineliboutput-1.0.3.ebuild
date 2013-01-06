# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-xineliboutput/vdr-xineliboutput-1.0.3.ebuild,v 1.2 2011/02/26 18:57:57 signals Exp $

inherit vdr-plugin eutils multilib versionator

MY_PV=${PV/_/}
MY_P=${PN}-${MY_PV}

SO_VERSION="${PV%_p*}"
SO_VERSION="${SO_VERSION/_/}"

DESCRIPTION="Video Disk Recorder Xinelib PlugIn"
HOMEPAGE="http://sourceforge.net/projects/xineliboutput/"
SRC_URI="mirror://sourceforge/${PN#vdr-}/${MY_P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="fbcon X libextractor"

RDEPEND=">=media-video/vdr-1.4.0
		>=media-libs/xine-lib-1.1.1
		virtual/jpeg
		libextractor? ( >=media-libs/libextractor-0.5.20 )
		X? (
			x11-proto/xextproto
			x11-proto/xf86vidmodeproto
			x11-proto/xproto
			x11-proto/renderproto
		)"

DEPEND="${RDEPEND}
		sys-kernel/linux-headers
		X? (
			x11-libs/libX11
			x11-libs/libXv
			x11-libs/libXext
			x11-libs/libXrender
		)"

S=${WORKDIR}/${MY_P#vdr-}

VDR_CONFD_FILE=${FILESDIR}/confd-1.0.0_pre6

use_onoff() {
	if use "$1"; then
		echo 1
	else
		echo 0
	fi
}

src_unpack() {
	vdr-plugin_src_unpack

	cd "${S}"

	XINE_PLUGIN_DIR=$(xine-config --plugindir)
	if [[ ${XINE_PLUGIN_DIR} = "" ]]; then
		eerror "Could not find xine plugin dir"
		die "Could not find xine plugin dir"
	fi
	# stop some automagic overwriting the stuff we set
	sed -e '/XINELIBOUTPUT_VDRPLUGIN = 1/s/^/#/' \
		-e '/HAVE_EXTRACTOR_H = 1/s/^/#/' \
		-i Makefile

	cat >>Make.config <<-EOF
		XINELIBOUTPUT_XINEPLUGIN = 1
		XINELIBOUTPUT_VDRPLUGIN = 1

		XINELIBOUTPUT_FB = $(use_onoff fbcon)
		XINELIBOUTPUT_X11 = $(use_onoff X)

		HAVE_XRENDER = 1
		HAVE_XDPMS = 1
		HAVE_EXTRACTOR_H = $(use_onoff libextractor)
	EOF

	# patching makefile to work with this
	# $ rm ${outdir}/file; cp file ${outdir}/file
	# work in the sandbox
	sed -i Makefile \
		-e 's:XINEPLUGINDIR.*=.*:XINEPLUGINDIR = '"${WORKDIR}/lib:" \
		-e 's:VDRINCDIR.*=.*:VDRINCDIR ?= /usr/include:'
	mkdir -p "${WORKDIR}/lib"
}

src_install() {
	vdr-plugin_src_install

	use fbcon && dobin vdr-fbfe
	use X && dobin vdr-sxfe

	# There may be no sub-plugin, depending on use-flags
	insinto ${VDR_PLUGIN_DIR}
	local f
	for f in libxineliboutput*.so.${SO_VERSION}; do
		[[ -f "$f" ]] || continue
		doins "${f}" || die "could not install sub-plugin ${f}"
	done

	insinto "${XINE_PLUGIN_DIR}"
	doins xineplug_inp_*.so

	insinto "${XINE_PLUGIN_DIR}"/post
	doins xineplug_post_*.so
}
