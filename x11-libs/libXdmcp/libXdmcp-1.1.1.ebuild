# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXdmcp/libXdmcp-1.1.1.ebuild,v 1.11 2014/04/15 19:25:35 vapier Exp $

EAPI=4

XORG_DOC=doc
inherit xorg-2

DESCRIPTION="X.Org X Display Manager Control Protocol library"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~ia64-hpux ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
IUSE=""

RDEPEND="x11-proto/xproto"
DEPEND="${RDEPEND}"

pkg_setup() {
	xorg-2_pkg_setup

	XORG_CONFIGURE_OPTIONS=(
		$(use_enable doc docs)
		$(use_with doc xmlto)
		--without-fop
	)
}
