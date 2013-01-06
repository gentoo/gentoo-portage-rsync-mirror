# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/hardinfo/hardinfo-0.5.2_pre20120527.ebuild,v 1.6 2012/12/31 14:18:36 hasufell Exp $

EAPI=4

inherit cmake-utils eutils multilib

DESCRIPTION="A system information and benchmark tool for Linux systems"
HOMEPAGE="http://hardinfo.berlios.de/"
SRC_URI="http://dev.gentoo.org/~hasufell/distfiles/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-libs/glib:2
	net-libs/libsoup
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	x11-libs/pango"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch \
		"${FILESDIR}"/${P}-underlinking.patch \
		"${FILESDIR}"/${P}-clang.patch

	sed \
		-e 's/g_build_filename(prefix, "lib"/g_build_filename(prefix, "'$(get_libdir)'"/' \
		-i hardinfo/binreloc.c || die
}
