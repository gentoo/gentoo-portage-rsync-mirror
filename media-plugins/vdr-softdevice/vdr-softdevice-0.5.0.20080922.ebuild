# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-softdevice/vdr-softdevice-0.5.0.20080922.ebuild,v 1.7 2012/05/05 08:27:15 jdhore Exp $

EAPI=3

inherit eutils vdr-plugin versionator

DESCRIPTION="VDR Plugin: Software output-Device"
HOMEPAGE="http://softdevice.berlios.de/"

# Detect snapshots
SNAP_V="$(get_version_component_range 4)"
if [[ "$SNAP_V" ]]; then
	MY_P="${PN}-cvs-${SNAP_V}"
	S="${WORKDIR}/${MY_P#vdr-}"
	SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
else
	SRC_URI="mirror://berlios/${PN#vdr-}/${P}.tgz"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="+xv fbcon directfb mmx mmxext xinerama"

RDEPEND=">=media-video/vdr-1.3.36
	>=virtual/ffmpeg-0.4.9_pre1
	directfb? (
		dev-libs/DirectFB
		dev-libs/DFB++
	)
	media-libs/alsa-lib
	xv? ( x11-libs/libX11
				x11-libs/libXext
				x11-libs/libXi
				x11-libs/libXv
				xinerama? ( x11-libs/libXinerama )
	)"

DEPEND="${RDEPEND}
	xv? ( x11-proto/xproto
				x11-proto/xextproto
				x11-libs/libXv
				xinerama? ( x11-proto/xineramaproto )
			)
	fbcon? ( sys-kernel/linux-headers )
	virtual/pkgconfig"
# Make sure the assembler USE flags are unmasked on amd64
# Remove this once default-linux/amd64/2006.1 is deprecated
DEPEND="${DEPEND} amd64? ( >=sys-apps/portage-2.1.2 )"

PATCHES=("${FILESDIR}/patches-0.4.0/shm-fullscreen-parameter.diff"
	"${FILESDIR}/${P}-offsett.patch" )

pkg_setup() {
	vdr-plugin_pkg_setup

	if ! use xv && ! use fbcon && ! use directfb; then
		ewarn "You need to set at least one of these use-flags: xv fbcon directfb"
		die "no output-method enabled"
	fi

	COMPILE_SHM=0
	if has_version ">=media-video/vdr-1.3.0"; then
		if use xv; then
			COMPILE_SHM=1
		else
			elog "SHM does only support xv at the moment"
		fi
	else
		elog "SHM not supported on vdr-1.2"
	fi
	case ${COMPILE_SHM} in
		0)	elog "SHM support will not be compiled." ;;
		1)	elog "SHM support will be compiled." ;;
	esac

	# Check for ffmpeg relying on libtheora without pkg-config-file
	# Bug #142250
	if has_version virtual/ffmpeg[theora] && \
		has_version "<media-libs/libtheora-1.0_alpha4"; then

			eerror "This package will not work when using ffmpeg with"
			eerror "USE=\"theora\" combined with media-libs/libtheora"
			eerror "older than version 1.0_alpha4."
			eerror "Please update to at least media-libs/libtheora-1.0_alpha4."
			die "Please update to at least media-libs/libtheora-1.0_alpha4."
	fi
}

src_configure() {
	local MYOPTS=""
	MYOPTS="${MYOPTS} --disable-vidix"
	use xv || MYOPTS="${MYOPTS} --disable-xv"
	use fbcon || MYOPTS="${MYOPTS} --disable-fb"
	use directfb || MYOPTS="${MYOPTS} --disable-dfb"

	use mmx || MYOPTS="${MYOPTS} --disable-mmx"
	use mmxext || MYOPTS="${MYOPTS} --disable-mmx2"

	if use !mmx && use !mmxext; then
		ewarn "${PN}"' does not compile with USE="-mmx -mmxext".'
		ewarn 'Please enable at least one of these two use-flags.'
		die "${PN}"' does not compile with USE="-mmx -mmxext".'
	fi

	use xinerama || MYOPTS="${MYOPTS} --disable-xinerama"

	[[ ${COMPILE_SHM} == 1 ]] || MYOPTS="${MYOPTS} --disable-shm"

	elog configure ${MYOPTS}
	./configure ${MYOPTS} || die "configure failed"
}

src_install() {
	vdr-plugin_src_install

	insinto "${VDR_PLUGIN_DIR}"
	doins libsoftdevice-*.so.*

	if [[ "${COMPILE_SHM}" = "1" ]]; then
		exeinto "/usr/bin"
		doexe ShmClient
		make_desktop_entry ShmClient "VDR softdevice Client" "" "AudioVideo;TV"
	fi

	insinto /usr/include/vdr-softdevice
	doins *.h
}
