# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cloog/cloog-0.18.0.ebuild,v 1.10 2014/06/22 14:45:28 hattya Exp $

EAPI="4"

inherit eutils

DESCRIPTION="A loop generator for scanning polyhedra"
HOMEPAGE="http://www.bastoul.net/cloog/index.php"
SRC_URI="http://www.bastoul.net/cloog/pages/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="static-libs"

DEPEND="dev-libs/gmp
	<dev-libs/isl-0.13
	!<dev-libs/cloog-ppl-0.15.10"
RDEPEND="${DEPEND}"

DOCS=( README )

src_prepare() {
	# m4/ax_create_pkgconfig_info.m4 includes LDFLAGS
	# sed to avoid eautoreconf
	sed -i -e '/Libs:/s:@LDFLAGS@ ::' configure || die
}

src_configure() {
	econf \
		--with-isl=system \
		--with-polylib=no \
		$(use_enable static-libs static)
}

src_install() {
	default
	prune_libtool_files
}
