# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXxf86dga/libXxf86dga-1.1.4.ebuild,v 1.9 2013/10/07 04:59:23 ago Exp $

EAPI=5

XORG_MULTILIB=yes
inherit xorg-2

DESCRIPTION="X.Org Xxf86dga library"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND="x11-libs/libX11[${MULTILIB_USEDEP}]
	x11-libs/libXext[${MULTILIB_USEDEP}]
	x11-proto/xextproto[${MULTILIB_USEDEP}]
	x11-proto/xproto[${MULTILIB_USEDEP}]
	>=x11-proto/xf86dgaproto-2.0.99.2[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"
