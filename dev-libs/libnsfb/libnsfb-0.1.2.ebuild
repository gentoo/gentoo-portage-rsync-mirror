# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libnsfb/libnsfb-0.1.2.ebuild,v 1.2 2014/11/17 03:44:00 patrick Exp $

EAPI=5

inherit netsurf

DESCRIPTION="framebuffer abstraction library, written in C"
HOMEPAGE="http://www.netsurf-browser.org/projects/libnsfb/"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="sdl test vnc wayland xcb"

RDEPEND="sdl? ( >=media-libs/libsdl-1.2.15-r4[static-libs?,${MULTILIB_USEDEP}] )
	vnc? ( >=net-libs/libvncserver-0.9.9-r2[static-libs?,${MULTILIB_USEDEP}] )
	wayland? ( >=dev-libs/wayland-1.0.6[static-libs?,${MULTILIB_USEDEP}] )
	xcb? ( >=x11-libs/libxcb-1.9.1[static-libs?,${MULTILIB_USEDEP}]
		>=x11-libs/xcb-util-0.3.9-r1[static-libs?,${MULTILIB_USEDEP}]
		>=x11-libs/xcb-util-image-0.3.9-r1[static-libs?,${MULTILIB_USEDEP}]
		>=x11-libs/xcb-util-keysyms-0.3.9-r1[static-libs?,${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/${PN}-0.1.0-autodetect.patch )
DOCS=( usage )
