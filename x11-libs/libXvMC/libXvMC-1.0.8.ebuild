# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXvMC/libXvMC-1.0.8.ebuild,v 1.10 2013/10/08 05:08:41 ago Exp $

EAPI=5

XORG_MULTILIB=yes
inherit xorg-2

DESCRIPTION="X.Org XvMC library"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x86-solaris"
IUSE=""

RDEPEND="x11-libs/libX11[${MULTILIB_USEDEP}]
	x11-libs/libXext[${MULTILIB_USEDEP}]
	x11-libs/libXv[${MULTILIB_USEDEP}]
	x11-proto/videoproto[${MULTILIB_USEDEP}]
	x11-proto/xproto[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"
PDEPEND="app-admin/eselect-xvmc"
