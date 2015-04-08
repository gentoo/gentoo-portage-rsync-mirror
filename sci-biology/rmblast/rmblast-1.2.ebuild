# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/rmblast/rmblast-1.2.ebuild,v 1.4 2013/02/18 10:48:11 jlec Exp $

EAPI="3"

inherit eutils flag-o-matic toolchain-funcs

MY_NCBI_BLAST_V=2.2.23+

DESCRIPTION="RepeatMasker compatible version of NCBI BLAST+"
HOMEPAGE="http://www.repeatmasker.org/RMBlast.html"
SRC_URI="http://www.repeatmasker.org/rmblast-${PV}-ncbi-blast-${MY_NCBI_BLAST_V}-src.tar.gz"

LICENSE="OSL-2.1"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-libs/boost-1.35.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}-ncbi-blast-${MY_NCBI_BLAST_V}-src/c++"

src_prepare() {
	filter-ldflags -Wl,--as-needed
	sed \
		-e 's/-print-file-name=libstdc++.a//' \
		-e '/sed/ s/\([gO]\[0-9\]\)\*/\1\\+/' \
		-e "/DEF_FAST_FLAGS=/s:=\".*\":=\"${CFLAGS}\":g" \
		-i src/build-system/configure || die
	epatch "${FILESDIR}"/${P}-gcc47.patch
}

src_configure() {
	tc-export CXX CC

	"${S}"/configure --without-debug \
		--with-mt \
		--without-static \
		--with-dll \
		--prefix="${ED}"/opt/${PN} \
		--with-boost="${EPREFIX}/usr/include/boost" \
		|| die
}
