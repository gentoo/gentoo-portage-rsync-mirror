# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmirage/libmirage-2.0.0.ebuild,v 1.1 2013/01/28 00:21:01 tetromino Exp $

EAPI="5"

CMAKE_MIN_VERSION="2.8.5"

inherit cmake-utils eutils fdo-mime

DESCRIPTION="CD and DVD image access library"
HOMEPAGE="http://cdemu.org"
SRC_URI="mirror://sourceforge/cdemu/${P}.tar.bz2"

LICENSE="GPL-2+"
SLOT="0/7" # subslot = libmirage soname version
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="doc +introspection"

RDEPEND=">=app-arch/bzip2-1:=
	>=app-arch/xz-utils-5:=
	>=dev-libs/glib-2.24:2
	>=media-libs/libsndfile-1.0:=
	sys-libs/zlib:=
	introspection? ( >=dev-libs/gobject-introspection-1.30 )"
DEPEND="${RDEPEND}
	dev-util/desktop-file-utils
	virtual/pkgconfig
	doc? ( dev-util/gtk-doc )"

src_prepare() {
	sed -e 's/-DG_DISABLE_DEPRECATED//' -i CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use doc GTKDOC_ENABLED)
		$(cmake-utils_use introspection INTROSPECTION_ENABLED)
	)
	cmake-utils_src_configure
}

src_install() {
	DOCS="AUTHORS README"
	cmake-utils_src_install
	prune_libtool_files --modules
}

pkg_postinst() {
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_mime_database_update
}
