# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-softdevice/vdr-softdevice-0.5.0.20110417.ebuild,v 1.1 2012/11/04 19:17:59 hd_brummy Exp $

EAPI="4"

inherit vdr-plugin-2 versionator

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
KEYWORDS="~amd64 ~x86"
IUSE="+xv fbcon directfb mmx mmxext xinerama"

# converted from built_with_use that had this comment:
# Check for ffmpeg relying on libtheora without pkg-config-file
# Bug #142250
RDEPEND=">=media-video/vdr-1.5.9
	|| (
		>=virtual/ffmpeg-0.10.2[-theora]
		(
			>=virtual/ffmpeg-0.10.2[theora]
			>=media-libs/libtheora-1.1.1
		)
	)
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
		"${FILESDIR}/softdevice-cvs-20110417_ffmpeg-0.10.2.diff")

REQUIRED_USE="^^ ( xv fbcon directfb )"

pkg_setup() {
	vdr-plugin-2_pkg_setup

	COMPILE_SHM=0

	if use xv; then
		COMPILE_SHM=1
	else
		elog "SHM does only support xv at the moment"
	fi

	case ${COMPILE_SHM} in
		0)	elog "SHM support will not be compiled." ;;
		1)	elog "SHM support will be compiled." ;;
	esac
}

src_prepare() {
	vdr-plugin-2_src_prepare

	sed -e "s:RegisterI18n://RegisterI18n:" -i softdevice.c

	# UINT64_C is needed by ffmpeg headers
	append-flags -D__STDC_CONSTANT_MACROS
}

src_configure() {
	local MYOPTS=""
	MYOPTS="${MYOPTS} --disable-vidix"
	use xv || MYOPTS="${MYOPTS} --disable-xv"
	use fbcon || MYOPTS="${MYOPTS} --disable-fb"
	use directfb || MYOPTS="${MYOPTS} --disable-dfb"

	use mmx || MYOPTS="${MYOPTS} --disable-mmx"
	use mmxext || MYOPTS="${MYOPTS} --disable-mmx2"

	use xinerama || MYOPTS="${MYOPTS} --disable-xinerama"

	[[ ${COMPILE_SHM} == 1 ]] || MYOPTS="${MYOPTS} --disable-shm"

	cd "${S}"
	elog configure ${MYOPTS}
	./configure ${MYOPTS} || die "configure failed"
}

src_install() {
	vdr-plugin-2_src_install

	cd "${S}"

	insinto "${VDR_PLUGIN_DIR}"
	doins libsoftdevice-*.so.*

	if [[ "${COMPILE_SHM}" = "1" ]]; then
		exeinto "/usr/bin"
		doexe ShmClient
		make_desktop_entry ShmClient "VDR softdevice Client" "" "AudioVideo;TV"
	fi

	# do we need this includes really in system?
	insinto /usr/include/vdr-softdevice
	doins *.h
}
