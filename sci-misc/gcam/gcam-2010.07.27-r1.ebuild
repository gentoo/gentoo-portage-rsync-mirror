# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/gcam/gcam-2010.07.27-r1.ebuild,v 1.3 2012/12/28 11:28:51 ago Exp $

EAPI=5

inherit autotools base

DESCRIPTION="GNU Computer Aided Manufacturing"
HOMEPAGE="http://gcam.js.cx"
SRC_URI="http://gcam.js.cx/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	dev-libs/expat
	dev-libs/glib:2
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
	"${FILESDIR}/${P}-cflags.patch"
	"${FILESDIR}/${P}-libpng15.patch"
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
