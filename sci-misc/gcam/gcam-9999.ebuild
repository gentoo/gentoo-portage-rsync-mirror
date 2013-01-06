# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/gcam/gcam-9999.ebuild,v 1.3 2012/11/19 15:51:40 kensington Exp $

EAPI=5
ESVN_REPO_URI="http://gcam.js.cx/svn/gcam/trunk"
ESVN_USER=gcam
ESVN_PASSWORD=gcam

inherit autotools base subversion

DESCRIPTION="GNU Computer Aided Manufacturing"
HOMEPAGE="http://gcam.js.cx"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/libxml2
	>=media-libs/libpng-1.5
	virtual/opengl
	virtual/glu
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	x11-libs/gtkglext
"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/${PN}-2010.07.27-cflags.patch"
	"${FILESDIR}/${PN}-2010.07.27-libpng15.patch"
)

src_prepare() {
	base_src_prepare
	eautoreconf
}

src_configure() {
	econf --enable-static=no
}

src_install() {
	default
	prune_libtool_files
}
