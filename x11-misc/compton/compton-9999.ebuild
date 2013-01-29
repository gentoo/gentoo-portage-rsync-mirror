# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/compton/compton-9999.ebuild,v 1.6 2013/01/29 11:19:36 hasufell Exp $

EAPI=5

inherit toolchain-funcs git-2

DESCRIPTION="A compositor for X, and a fork of xcompmgr-dana"
HOMEPAGE="http://github.com/chjj/compton"
SRC_URI=""

EGIT_REPO_URI="git://github.com/chjj/compton.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="dbus +drm opengl +pcre"

COMMON_DEPEND="dev-libs/libconfig
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libXrender
	dbus? ( sys-apps/dbus )
	opengl? ( virtual/opengl )
	pcre? ( dev-libs/libpcre:3 )"
RDEPEND="${COMMON_DEPEND}
	x11-apps/xprop
	x11-apps/xwininfo"
DEPEND="${COMMON_DEPEND}
	app-text/asciidoc
	virtual/pkgconfig
	x11-proto/xproto
	drm? ( x11-libs/libdrm )"

nobuildit() { use $1 || echo yes ; }

pkg_setup() {
	tc-export CC
}

src_compile() {
	emake docs
	NO_DBUS=$(nobuildit dbus) \
	NO_VSYNC_DRM=$(nobuildit drm) \
	NO_VSYNC_OPENGL=$(nobuildit opengl) \
	NO_REGEX_PCRE=$(nobuildit pcre) \
		emake compton
}

src_install() {
	NO_DBUS=$(nobuildit dbus) \
	NO_VSYNC_DRM=$(nobuildit drm) \
	NO_VSYNC_OPENGL=$(nobuildit opengl) \
	NO_REGEX_PCRE=$(nobuildit pcre) \
		default
	docinto examples
	nonfatal dodoc compton.sample.conf dbus-examples/*
}
