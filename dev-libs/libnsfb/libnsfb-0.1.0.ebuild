# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libnsfb/libnsfb-0.1.0.ebuild,v 1.3 2014/06/17 17:37:59 mgorny Exp $

EAPI=5

inherit netsurf

DESCRIPTION="framebuffer abstraction library, written in C"
HOMEPAGE="http://www.netsurf-browser.org/projects/libnsfb/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE="sdl test vnc wayland xcb"

RDEPEND="sdl? ( media-libs/libsdl[static-libs?,${MULTILIB_USEDEP}] )
	vnc? ( net-libs/libvncserver[static-libs?,${MULTILIB_USEDEP}] )
	wayland? ( dev-libs/wayland[static-libs?,${MULTILIB_USEDEP}] )
	xcb? ( x11-libs/libxcb[static-libs?,${MULTILIB_USEDEP}]
		x11-libs/xcb-util[static-libs?,${MULTILIB_USEDEP}]
		x11-libs/xcb-util-image[static-libs?,${MULTILIB_USEDEP}]
		x11-libs/xcb-util-keysyms[static-libs?,${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/${PN}-0.1.0-autodetect.patch )
DOCS=( usage )
