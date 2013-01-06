# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/vaal/vaal-42179.ebuild,v 1.1 2012/06/25 19:09:19 jlec Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=yes

inherit autotools-utils

DESCRIPTION="A variant ascertainment algorithm that can be used to detect SNPs, indels, and other polymorphisms"
HOMEPAGE="http://www.broadinstitute.org/science/programs/genome-biology/crd/"
SRC_URI="
	ftp://ftp.broad.mit.edu/pub/crd/VAAL/latest_source_code/${P}.tar.gz
	ftp://ftp.broad.mit.edu/pub/crd/VAAL/VAAL_manual.doc"

LICENSE="Whitehead-MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="openmp"

DEPEND=">=dev-libs/boost-1.41.0-r3"
RDEPEND="${DEPEND}"

DOCS=( "${DISTDIR}/VAAL_manual.doc" )

src_prepare() {
	sed \
		-e '/COPYING/d' \
		-i src/Makefile.am || die

	sed \
		-e 's:-ggdb3::g' \
		-e '/AC_OPENMP_CEHCK/d' \
		-i configure.ac || die
	autotools-utils_src_prepare
}

src_configure(){
	local myeconfargs=( $(use_enable openmp) )
	autotools-utils_src_configure
}
