# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXScrnSaver/libXScrnSaver-1.2.2-r1.ebuild,v 1.9 2013/10/07 04:59:04 ago Exp $

EAPI=5

XORG_MULTILIB=yes
inherit xorg-2

DESCRIPTION="X.Org XScrnSaver library"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc ~x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

RDEPEND="x11-libs/libX11[${MULTILIB_USEDEP}]
	x11-libs/libXext[${MULTILIB_USEDEP}]
	>=x11-proto/scrnsaverproto-1.2[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"
