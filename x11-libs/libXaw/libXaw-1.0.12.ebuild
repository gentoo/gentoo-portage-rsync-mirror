# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXaw/libXaw-1.0.12.ebuild,v 1.3 2013/10/02 03:50:03 jer Exp $

EAPI=5

XORG_DOC=doc
XORG_MULTILIB=yes
inherit xorg-2

DESCRIPTION="X.Org Xaw library"

KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="deprecated"

RDEPEND="x11-libs/libX11[${MULTILIB_USEDEP}]
	x11-libs/libXext[${MULTILIB_USEDEP}]
	x11-libs/libXt[${MULTILIB_USEDEP}]
	x11-libs/libXmu[${MULTILIB_USEDEP}]
	x11-libs/libXpm[${MULTILIB_USEDEP}]
	x11-proto/xproto[${MULTILIB_USEDEP}]
	x11-proto/xextproto[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"

src_configure() {
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable deprecated xaw6)
		$(use_enable doc specs)
		$(use_with doc xmlto)
		--without-fop
	)
	xorg-2_src_configure
}
