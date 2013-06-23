# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libnsfb/libnsfb-0.1.0.ebuild,v 1.2 2013/06/23 16:45:19 xmw Exp $

EAPI=5

inherit netsurf

DESCRIPTION="framebuffer abstraction library, written in C"
HOMEPAGE="http://www.netsurf-browser.org/projects/libnsfb/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE="sdl test vnc wayland xcb"

RDEPEND="sdl? ( media-libs/libsdl[static-libs?]
		amd64? ( abi_x86_32? ( app-emulation/emul-linux-x86-sdl[development] ) ) )
	vnc? ( net-libs/libvncserver[static-libs?] )
	wayland? ( dev-libs/wayland[static-libs?] )
	xcb? ( x11-libs/libxcb[static-libs?,${MULTILIB_USEDEP}]
		x11-libs/xcb-util[static-libs?]
		x11-libs/xcb-util-image[static-libs?]
		x11-libs/xcb-util-keysyms[static-libs?] )"
DEPEND="${RDEPEND}"

REQUIRED_USE="amd64? ( abi_x86_32? ( !vnc !wayland !xcb ) )"

PATCHES=( "${FILESDIR}"/${PN}-0.1.0-autodetect.patch )
DOCS=( usage )
