# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/xpra/xpra-0.9.5-r1.ebuild,v 1.1 2013/06/09 21:17:51 xmw Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
inherit distutils-r1 eutils

DESCRIPTION="X Persistent Remote Apps (xpra) and Partitioning WM (parti) based on wimpiggy"
HOMEPAGE="http://xpra.org/"
SRC_URI="http://xpra.org/src/${P}.tar.bz2"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="+clipboard pulseaudio +rencode server vpx webp x264"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# x264/old-libav.path situation see bug 459218
COMMON_DEPEND=""${PYTHON_DEPS}"
	dev-python/pygobject:2[${PYTHON_USEDEP}]
	dev-python/pygtk:2[${PYTHON_USEDEP}]
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libXtst
	vpx? ( media-libs/libvpx
		virtual/ffmpeg )
	webp? ( media-libs/libwebp )
	x264? ( media-libs/x264
		|| ( >=media-video/ffmpeg-1.0.4 media-video/libav )
		virtual/ffmpeg )"

RDEPEND="${COMMON_DEPEND}
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/ipython[${PYTHON_USEDEP}]
	virtual/python-imaging[${PYTHON_USEDEP}]
	virtual/ssh
	x11-apps/setxkbmap
	x11-apps/xmodmap
	server? ( x11-base/xorg-server[-minimal,xvfb]
		x11-drivers/xf86-input-void
		x11-drivers/xf86-video-dummy
	)"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	>=dev-python/cython-0.16[${PYTHON_USEDEP}]"

python_prepare_all() {
	epatch \
		"${FILESDIR}"/${PN}-0.7.1-ignore-gentoo-no-compile.patch \
		"${FILESDIR}"/${PN}-0.8.0-prefix.patch \
		"${FILESDIR}"/${PN}-0.9.5-PIL.patch

	#assuming ffmpeg and libav mutual exclusive installs
	if has_version "media-video/libav" ; then
		if ! has_version ">=media-video/libav-9" ; then
			epatch patches/old-libav.patch
		fi
	fi

	use clipboard  || epatch patches/disable-clipboard.patch
	use pulseaudio || epatch patches/disable-pulseaudio.patch
	use rencode    || epatch patches/disable-rencode.patch
	use server     || epatch patches/disable-posix-server.patch
	use vpx        || epatch patches/disable-vpx.patch
	use webp       || epatch patches/disable-webp.patch
	use x264       || epatch patches/disable-x264.patch
}

src_install() {
	distutils-r1_src_install

	rm -vf "${ED}"usr/share/parti/{parti.,}README \
		"${ED}"usr/share/xpra/{webm/LICENSE,xpra.README} \
		"${ED}"usr/share/wimpiggy/wimpiggy.README || die
	dodoc {parti.,wimpiggy.,xpra.,}README
}
