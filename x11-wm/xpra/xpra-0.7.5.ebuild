# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/xpra/xpra-0.7.5.ebuild,v 1.1 2012/12/07 08:23:56 xmw Exp $

EAPI=3

PYTHON_DEPEND="*"
#dev-python/pygobject and dev-python/pygtk do not support python3
RESTRICT_PYTHON_ABIS="2.4 2.5 3.*"
DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"
SUPPORT_PYTHON_ABIS="1"
inherit distutils eutils

DESCRIPTION="X Persistent Remote Apps (xpra) and Partitioning WM (parti) based on wimpiggy"
HOMEPAGE="http://xpra.org/"
SRC_URI="http://xpra.org/src/${P}.tar.bz2"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="+clipboard +rencode server vpx webp x264"

COMMON_DEPEND="dev-python/pygobject:2
	dev-python/pygtk:2
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
		virtual/ffmpeg )"

RDEPEND="${COMMON_DEPEND}
	dev-python/dbus-python
	dev-python/imaging
	dev-python/ipython
	virtual/ssh
	x11-apps/setxkbmap
	x11-apps/xmodmap
	server? ( x11-base/xorg-server[-minimal]
		x11-drivers/xf86-input-void
		x11-drivers/xf86-video-dummy
	)"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	>=dev-python/cython-0.16"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.7.1-ignore-gentoo-no-compile.patch
	epatch "${FILESDIR}"/${PN}-0.7.4-prefix.patch

	use clipboard || epatch patches/disable-clipboard.patch
	use rencode   || epatch patches/disable-rencode.patch
	use server    || epatch patches/disable-posix-server.patch
	use vpx       || epatch patches/disable-vpx.patch
	use webp      || epatch patches/disable-webp.patch
	use x264      || epatch patches/disable-x264.patch

	distutils_src_prepare

	patching() {
	    [[ "${PYTHON_ABI}" == 2.* ]] && return
		2to3 --no-diffs -x all -f except -w -n .
	}
	python_execute_function --action-message \
		'Applying patches with $(python_get_implementation) $(python_get_version)' \
		-s patching
}

src_install() {
	distutils_src_install
	rm -v "${ED}"usr/share/parti/{parti.,}README \
		"${ED}"usr/share/xpra/{webm/LICENSE,xpra.README} \
		"${ED}"usr/share/wimpiggy/wimpiggy.README
	dodoc {parti.,wimpiggy.,xpra.,}README

	einfo
	elog "please make your Xorg binary readable for users of xpra"
	elog "  chmod a+r /usr/bin/Xorg"
	elog "and think about the security impact"
	einfo
}
