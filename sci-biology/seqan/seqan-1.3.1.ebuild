# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/seqan/seqan-1.3.1.ebuild,v 1.1 2013/03/13 16:08:31 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit cmake-utils flag-o-matic python-single-r1

DESCRIPTION="C++ Sequence Analysis Library"
HOMEPAGE="http://www.seqan.de/"
SRC_URI="http://ftp.seqan.de/releases/${P}.zip"

SLOT="0"
LICENSE="BSD GPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${P}/cmake

src_prepare() {
	append-cppflags -I"${EPREFIX}/usr/include/bam"
	rm -rf "${S}"/../lib/samtools || die

	sed \
		-e "s:docs:docs/.:g" \
		-e "/DESTINATION/s:seqan:docs/${PF}/html:g" \
		-i CMakeLists.txt || die

	sed \
		-e "/DESTINATION/s:bin):share/${PN}):g" \
		-i apps/CMakeLists.txt || die

	cmake-utils_src_prepare
}
