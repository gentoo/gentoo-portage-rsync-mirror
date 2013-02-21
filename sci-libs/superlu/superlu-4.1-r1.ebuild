# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/superlu/superlu-4.1-r1.ebuild,v 1.12 2013/02/21 21:23:07 jlec Exp $

EAPI="2"

inherit autotools eutils fortran-2 toolchain-funcs multilib

MY_PN=SuperLU

DESCRIPTION="Sparse LU factorization library"
HOMEPAGE="http://crd.lbl.gov/~xiaoye/SuperLU/"
SRC_URI="${HOMEPAGE}/${PN}_${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="doc examples static-libs test"

RDEPEND="
	virtual/blas"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	test? ( app-shells/tcsh )"

S="${WORKDIR}/${MY_PN}_${PV}"

src_prepare() {
	unset VERBOSE
	epatch "${FILESDIR}"/${P}-autotools.patch
	sed \
		-e "s:= ar:= $(tc-getAR):g" \
		-e "s:= ranlib:= $(tc-getRANLIB):g" \
		-i make.inc || die
	eautoreconf
}

src_configure() {
	econf \
		--with-blas="$($(tc-getPKG_CONFIG) --libs blas)" \
		$(use_enable static-libs static)
}

src_test() {
	cd TESTING
	emake -j1 \
		CC="$(tc-getCC)" \
		AR="$(tc-getAR)" \
		RANLIB="$(tc-getRANLIB)" \
		FORTRAN="$(tc-getFC)" \
		LOADER="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		FFLAGS="${FFLAGS}" \
		LOADOPTS="${LDFLAGS}" \
		BLASLIB="$($(tc-getPKG_CONFIG) --libs blas)" \
		SUPERLULIB="${S}/SRC/.libs/libsuperlu$(get_libname)" \
		LD_LIBRARY_PATH="${S}/SRC/.libs" \
		DYLD_LIBRARY_PATH="${S}/SRC/.libs" \
		|| die "emake matrix generation failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README

	if use doc; then
		dodoc DOC/ug.pdf || die
		dohtml DOC/html/* || die
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r EXAMPLE FORTRAN || die
	fi
}
