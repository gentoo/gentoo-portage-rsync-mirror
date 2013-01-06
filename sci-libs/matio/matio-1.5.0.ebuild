# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/matio/matio-1.5.0.ebuild,v 1.2 2012/08/03 22:14:07 bicatali Exp $

EAPI=4
inherit autotools eutils

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

src_prepare() {
	epatch "${FILESDIR}"/${P}-asneeded.patch
	eautoreconf
}

src_configure() {
	econf \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		--enable-shared \
		$(use_enable hdf5 mat73) \
		$(use_enable sparse extended-sparse) \
		$(use_enable static-libs static)
}

src_compile() {
	emake
	use doc && emake -C documentation pdf
}

src_install() {
	default
	use doc && dodoc documentation/matio_user_guide.pdf
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins test/test*
		insinto /usr/share/${PN}
		doins share/test*
	fi
}
