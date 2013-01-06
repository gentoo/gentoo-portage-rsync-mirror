# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/arpack/arpack-0.96-r3.ebuild,v 1.4 2012/10/19 10:39:22 jlec Exp $

EAPI=4

inherit autotools eutils flag-o-matic fortran-2 toolchain-funcs

MY_PV="96"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Arnoldi package library to solve large scale eigenvalue problems."
HOMEPAGE="http://www.caam.rice.edu/software/ARPACK/"
SRC_URI="
	http://www.caam.rice.edu/software/ARPACK/SRC/${PN}${MY_PV}.tar.gz
	http://www.caam.rice.edu/software/ARPACK/SRC/p${PN}${MY_PV}.tar.gz
	http://dev.gentoo.org/~bicatali/${MY_P}-patches-2.tar.bz2
	doc? (
		http://www.caam.rice.edu/software/ARPACK/SRC/ug.ps.gz
		http://www.caam.rice.edu/software/ARPACK/DOCS/tutorial.ps.gz )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="doc examples mpi static-libs"

RDEPEND="
	virtual/blas
	virtual/lapack
	mpi? ( virtual/mpi[fortran] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/ARPACK"

src_unpack() {
	unpack ${A}
	unpack ./*patch.tar.gz
}

src_prepare() {
	cd "${WORKDIR}"
	epatch "${WORKDIR}"/${PN}-arscnd.patch
	# http://savannah.gnu.org/bugs/?func=detailitem&item_id=31479
	epatch "${WORKDIR}"/${PN}-neupd.patch
	epatch "${WORKDIR}"/${PN}-autotools.patch

	cd "${S}"
	# fix examples library paths
	sed -i \
		-e '/^include/d' \
		-e "s:\$(ALIBS):-larpack $(pkg-config --libs blas lapack):g" \
		-e 's:$(FFLAGS):$(FFLAGS) $(LDFLAGS):g' \
		EXAMPLES/*/makefile || die "sed failed"

	sed -i \
		-e '/^include/d' \
		-e "s:\$(PLIBS):-larpack -lparpack $(pkg-config --libs blas lapack):g" \
		-e 's:_$(PLAT)::g' \
		-e 's:$(PFC):mpif77:g' \
		-e 's:$(PFFLAGS):$(FFLAGS) $(LDFLAGS) $(EXTOBJS):g' \
		PARPACK/EXAMPLES/MPI/makefile || die "sed failed"

	# bug #354993
	rm -f PARPACK/{SRC,UTIL,EXAMPLES}/MPI/mpif.h
	#ln -s "${EPREFIX}"/usr/include/mpif*.h PARPACK/SRC/MPI/
	eautoreconf
}

src_configure() {
	econf \
		--with-blas="$(pkg-config --libs blas)" \
		--with-lapack="$(pkg-config --libs lapack)" \
		$(use_enable static-libs static) \
		$(use_enable mpi)
}

src_test() {
	pushd EXAMPLES/SIMPLE
	emake simple FC=$(tc-getFC) LDFLAGS="${LDFLAGS} -L${S}/.libs"
	local prog=
	for p in ss ds sn dn cn zn; do
		prog=${p}simp
		LD_LIBRARY_PATH="${S}/.libs" ./${prog} \
			|| die "${prog} test failed"
		rm -f ${prog} *.o
	done
	popd

	if use mpi; then
		pushd PARPACK/EXAMPLES/MPI
		mpif77 ${FFLAGS} -c ../../../LAPACK/dpttr{f,s}.f \
			|| die "compiling dpttrf,s failed"
		emake \
			FC=mpif77 \
			EXTOBJS="dpttr{f,s}.o" \
			LDFLAGS="${LDFLAGS} -L${S}/.libs -L${S}/PARPACK/.libs" \
			pdndrv || die "emake pdndrv failed"
		for p in 1 3; do
			prog=pdndrv${p}
			LD_LIBRARY_PATH="${S}/.libs:${S}/PARPACK/.libs" \
				./${prog} || die "${prog} test failed"
			rm -f ${prog} *.o
		done
		popd
	fi
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc README DOCUMENTS/*.doc
	newdoc DOCUMENTS/README README.doc
	use doc && dodoc "${WORKDIR}"/*.ps
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r EXAMPLES
		if use mpi; then
			insinto /usr/share/doc/${PF}/EXAMPLES/PARPACK
			doins -r PARPACK/EXAMPLES/MPI
		fi
	fi
}
