# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXrandr/libXrandr-1.4.2.ebuild,v 1.9 2013/10/07 04:58:55 ago Exp $

EAPI=5

XORG_MULTILIB=yes
inherit xorg-2

DESCRIPTION="X.Org Xrandr library"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
IUSE=""

RDEPEND="x11-libs/libX11[${MULTILIB_USEDEP}]
	x11-libs/libXext[${MULTILIB_USEDEP}]
	x11-libs/libXrender[${MULTILIB_USEDEP}]
	x11-proto/randrproto[${MULTILIB_USEDEP}]
	x11-proto/renderproto[${MULTILIB_USEDEP}]
	x11-proto/xextproto[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"
