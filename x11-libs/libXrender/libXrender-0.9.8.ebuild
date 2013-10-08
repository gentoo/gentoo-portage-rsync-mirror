# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXrender/libXrender-0.9.8.ebuild,v 1.10 2013/10/08 05:08:23 ago Exp $

EAPI=5

XORG_MULTILIB=yes
inherit xorg-2

DESCRIPTION="X.Org Xrender library"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
IUSE=""

RDEPEND="x11-libs/libX11[${MULTILIB_USEDEP}]
	>=x11-proto/renderproto-0.9.3[${MULTILIB_USEDEP}]
	x11-proto/xproto[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"
