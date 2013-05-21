# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gmetadom/gmetadom-0.2.6-r1.ebuild,v 1.6 2013/05/21 15:51:46 jer Exp $

EAPI=5

inherit autotools-utils flag-o-matic

DESCRIPTION="A library providing bindings for multiple languages of multiple C DOM implementations"
HOMEPAGE="http://gmetadom.sourceforge.net/"
SRC_URI="mirror://sourceforge/gmetadom/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ppc ~ppc64 ~sparc x86"
IUSE="ocaml static-libs"

RDEPEND="dev-libs/glib
	dev-libs/gdome2
	dev-libs/libxslt"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	ocaml? (
		dev-lang/ocaml
		dev-ml/findlib
	)"

AUTOTOOLS_IN_SOURCE_BUILD="yes"
AUTOTOOLS_AUTORECONF="yes"
MAKEOPTS="${MAKEOPTS} -j1"
PATCHES=(
	"${FILESDIR}"/${P}-gentoo-2.patch
	"${FILESDIR}"/${P}-gcc43.patch
	"${FILESDIR}"/${P}-automake-1.13.patch
)

src_configure() {
	# Unconditonal use of -fPIC (#55238).
	append-flags -fPIC

	local myeconfargs=(
		--with-modules="gdome_cpp_smart $(use ocaml && echo gdome_caml)"
	)
	autotools-utils_src_configure
}
