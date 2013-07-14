# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/weston/weston-1.2.0.ebuild,v 1.2 2013/07/14 20:56:05 chithanh Exp $

EAPI=5

if [[ ${PV} = 9999* ]]; then
	EGIT_REPO_URI="git://anongit.freedesktop.org/git/wayland/${PN}"
	GIT_ECLASS="git-2"
	EXPERIMENTAL="true"
fi

inherit autotools toolchain-funcs $GIT_ECLASS

DESCRIPTION="Wayland reference compositor"
HOMEPAGE="http://wayland.freedesktop.org/"

if [[ $PV = 9999* ]]; then
	SRC_URI="${SRC_PATCHES}"
	KEYWORDS=""
else
	SRC_URI="http://wayland.freedesktop.org/releases/${P}.tar.xz"
	KEYWORDS="~arm ~amd64 ~x86 ~arm-linux"
fi

LICENSE="MIT CC-BY-SA-3.0"
SLOT="0"
IUSE="+clients colord debug +drm +egl headless fbdev gles2 rdp +resize-optimization rpi +simple-clients static-libs +tablet +wayland-compositor +xwayland +x11"

REQUIRED_USE="
	rpi?   ( !drm !egl gles2 )
"

RDEPEND="
	>=dev-libs/wayland-1.1.90
	gnome-base/librsvg
	media-libs/mesa[gles2,wayland]
	x11-libs/pixman
	clients? ( >=x11-libs/cairo-1.10.0
		x11-libs/gdk-pixbuf
		dev-libs/glib:2
		x11-libs/libxkbcommon
		media-libs/libpng
		app-text/poppler )
	colord? ( x11-misc/colord )
	debug? ( sys-libs/libunwind )
	drm? ( >=virtual/udev-136
		>=x11-libs/libdrm-2.4.30
		media-libs/mesa[gbm] )
	egl? ( media-libs/mesa[egl] )
	gles2? ( x11-libs/cairo[gles2] )
	rdp? ( >=net-misc/freerdp-1.1.0_beta1_p20130710 )
	x11? ( x11-libs/libxcb
		x11-libs/libX11 )"
DEPEND="${RDEPEND}"

src_prepare() {
	if [[ ${PV} = 9999* ]]; then
		eautoreconf
	fi
}

src_configure() {
	econf --disable-setuid-install \
		  $(use_enable clients) \
		  $(use_enable colord) \
		  $(use_enable debug libunwind) \
		  $(use_enable drm drm-compositor) \
		  $(use_enable egl) \
		  $(use_enable fbdev fbdev-compositor) \
		  $(use_enable headless headless-compositor) \
		  $(use_enable rdp rdp-compositor) \
		  $(use_enable resize-optimization) \
		  $(use_enable rpi rpi-compositor) \
		  $(use_enable simple-clients) \
		  $(use_enable static-libs static) \
		  $(use_enable tablet tablet-shell) \
		  $(use_enable wayland-compositor) \
		  $(use_enable xwayland xwayland-compositor) \
		  $(use_enable x11 x11-compositor) \
		  $(use_with gles2 cairo-glesv2)
}
