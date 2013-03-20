# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/matio/matio-1.5.1.ebuild,v 1.1 2013/03/20 21:33:16 bicatali Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=1
inherit autotools-utils eutils

DESCRIPTION="Library for reading and writing matlab files"
HOMEPAGE="http://sourceforge.net/projects/matio/"
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples hdf5 sparse static-libs"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RDEPEND="sys-libs/zlib
	hdf5? ( sci-libs/hdf5 )"
DEPEND="${RDEPEND}
	doc? ( virtual/latex-base )"

PATCHES=( "${FILESDIR}"/${PN}-1.5.0-asneeded.patch )

src_configure() {
	local myeconfargs=(
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
		$(use_enable hdf5 mat73)
		$(use_enable sparse extended-sparse)
	)
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile
	use doc && 	autotools-utils_src_compile -C documentation pdf
}

src_install() {
	autotools-utils_src_install
	use doc && dodoc documentation/matio_user_guide.pdf
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins test/test*
		insinto /usr/share/${PN}
		doins share/test*
	fi
}
