# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/wcslib/wcslib-4.15.ebuild,v 1.2 2012/10/19 10:45:53 jlec Exp $

EAPI=4

FORTRAN_NEEDED=fortran

inherit eutils fortran-2 multilib

DESCRIPTION="Astronomical World Coordinate System transformations library"
HOMEPAGE="http://www.atnf.csiro.au/people/mcalabre/WCS/"
SRC_URI="ftp://ftp.atnf.csiro.au/pub/software/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="LGPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc fortran fits pgplot static-libs"

RDEPEND="
	fits? ( sci-libs/cfitsio )
	pgplot? ( sci-libs/pgplot )"
DEPEND="${RDEPEND}
	sys-devel/flex"

src_prepare() {
	sed -i -e 's/COPYING\*//' GNUmakefile || die
}

src_configure() {
	econf \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		$(use_enable static-libs static) \
		$(use_enable fortran) \
		$(use_with fits cfitsio) \
		$(use_with pgplot)
}

src_compile() {
	# nasty makefile, debugging means full rewrite
	emake -j1
}

src_test() {
	emake -j1 check
}

src_install () {
	default
	# static libs are same as shared (compiled with PIC)
	# so they are not compiled twice
	use static-libs || rm "${ED}"/usr/$(get_libdir)/lib*.a
	use doc || rm -r "${ED}"/usr/share/doc/${PF}/html \
		"${ED}"/usr/share/doc/${PF}/*.pdf
}
