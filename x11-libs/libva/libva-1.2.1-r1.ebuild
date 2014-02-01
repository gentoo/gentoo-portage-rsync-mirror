# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libva/libva-1.2.1-r1.ebuild,v 1.1 2014/02/01 15:24:22 axs Exp $

EAPI=5

SCM=""
if [ "${PV%9999}" != "${PV}" ] ; then # Live ebuild
	SCM=git-2
	EGIT_BRANCH=master
	EGIT_REPO_URI="git://anongit.freedesktop.org/vaapi/libva"
fi

AUTOTOOLS_AUTORECONF="yes"
inherit autotools-multilib ${SCM} multilib

DESCRIPTION="Video Acceleration (VA) API for Linux"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/vaapi"
if [ "${PV%9999}" != "${PV}" ] ; then # Live ebuild
	SRC_URI=""
	S="${WORKDIR}/${PN}"
else
	SRC_URI="http://www.freedesktop.org/software/vaapi/releases/libva/${P}.tar.bz2"
fi

LICENSE="MIT"
SLOT="0"
if [ "${PV%9999}" = "${PV}" ] ; then
	KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
else
	KEYWORDS=""
fi
IUSE="+drm egl opengl vdpau wayland X"
REQUIRED_USE="|| ( drm wayland X )"

VIDEO_CARDS="dummy nvidia intel fglrx"
for x in ${VIDEO_CARDS}; do
	IUSE+=" video_cards_${x}"
done

RDEPEND=">=x11-libs/libdrm-2.4[${MULTILIB_USEDEP}]
	X? (
		x11-libs/libX11[${MULTILIB_USEDEP}]
		x11-libs/libXext[${MULTILIB_USEDEP}]
		x11-libs/libXfixes[${MULTILIB_USEDEP}]
	)
	egl? ( media-libs/mesa[egl,${MULTILIB_USEDEP}] )
	opengl? ( virtual/opengl )
	wayland? ( >=dev-libs/wayland-1[${MULTILIB_USEDEP}] )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"
PDEPEND="video_cards_nvidia? ( x11-libs/libva-vdpau-driver[${MULTILIB_USEDEP}] )
	vdpau? ( x11-libs/libva-vdpau-driver[${MULTILIB_USEDEP}] )
	video_cards_fglrx? ( x11-libs/xvba-video[${MULTILIB_USEDEP}] )
	video_cards_intel? ( >=x11-libs/libva-intel-driver-1.0.18[${MULTILIB_USEDEP}] )
	"

REQUIRED_USE="opengl? ( X )"

PATCHES=( "${FILESDIR}/${PN}-1.2.0-autotools-out-of-source-build.patch" )
DOCS=( NEWS )

MULTILIB_WRAPPED_HEADERS=(
/usr/include/va/va_backend_glx.h
/usr/include/va/va_x11.h
/usr/include/va/va_dri2.h
/usr/include/va/va_dricommon.h
/usr/include/va/va_glx.h
)

multilib_src_configure() {
	local myeconfargs=(
		--with-drivers-path="${EPREFIX}/usr/$(get_libdir)/va/drivers"
		$(use_enable video_cards_dummy dummy-driver)
		$(use_enable opengl glx)
		$(use_enable X x11)
		$(use_enable wayland)
		$(use_enable egl)
		$(use_enable drm)
	)
	autotools-utils_src_configure
}
