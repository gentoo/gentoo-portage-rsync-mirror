# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xpyb/xpyb-1.2-r1.ebuild,v 1.5 2013/05/11 07:26:11 patrick Exp $

inherit x-modular autotools

EGIT_REPO_URI="git://anongit.freedesktop.org/git/xcb/xpyb"
SRC_URI="http://xcb.freedesktop.org/dist/${P}.tar.bz2"
DESCRIPTION="XCB-based Python bindings for the X Window System"
HOMEPAGE="http://xcb.freedesktop.org/ http://pypi.python.org/pypi/xpyb"

KEYWORDS="amd64 x86"
IUSE="selinux"

RDEPEND=">=x11-libs/libxcb-1.1
	>=dev-lang/python-2.5"
DEPEND="${RDEPEND}
	>=x11-proto/xcb-proto-1.2"

DOCS="NEWS README"

pkg_setup() {
	CONFIGURE_OPTIONS="$(use_enable selinux xselinux)"
}

src_unpack() {
	x-modular_src_unpack

	eautoreconf
}
