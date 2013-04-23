# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/apbs/apbs-1.3-r3.ebuild,v 1.4 2013/04/23 14:01:33 jlec Exp $

EAPI=4

PYTHON_DEPEND="python? 2"

inherit autotools-utils eutils fortran-2 python toolchain-funcs versionator

MY_PV=$(get_version_component_range 1-3)
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Evaluation of electrostatic properties of nanoscale biomolecular systems"
HOMEPAGE="http://www.poissonboltzmann.org/apbs/"
SRC_URI="mirror://sourceforge/${PN}/${P}-source.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="arpack doc examples fetk mpi openmp python static-libs tools"
REQUIRED_USE="mpi? ( !python )"

RDEPEND="
	dev-libs/maloc[mpi=]
	virtual/blas
	sys-libs/readline
	arpack? ( sci-libs/arpack )
	fetk? (
		sci-libs/fetk
		sci-libs/amd
		sci-libs/umfpack
		sci-libs/superlu )
	mpi? ( virtual/mpi )"
DEPEND="${DEPEND}
	virtual/pkgconfig"

S="${WORKDIR}"/"${MY_P}-source"

AUTOTOOLS_IN_SOURCE_BUILD=1
MAKEOPTS+=" -j1"

pkg_setup() {
	fortran-2_pkg_setup
	use python && python_set_active_version 2 && python_pkg_setup
	if [[ -z ${MAXMEM} ]]; then
		einfo "You can specify the max amount of RAM used"
		einfo "by setting MAXMEM=\"your size in MB\""
	else
		einfo "Settings max memory usage to ${MAXMEM} MB"
	fi
}

# git clone ssh://woodpecker/home/jlec/apbs.git
PATCHES=( "${FILESDIR}"/${P}/00{01..16}* )

src_prepare() {
	rm -rf contrib/{blas,maloc,opal,zlib} || die
	find -name "._*" -delete || die

	EPATCH_OPTS="-p1" \
		autotools-utils_src_prepare

	sed \
		-e "s:GENTOO_PKG_NAME:${PN}:g" \
		-i Makefile.am || die "Cannot correct package name"
	sed \
		-e 's:libmaloc.a:libmaloc.so:g' \
		-e 's:-lblas::g' \
		-i configure.ac || die
	sed -e 's:opal::g' -i contrib/Makefile.am || die
	sed \
		-e 's:noinst_PROGRAMS:bin_PROGRAMS:g' \
		-i tools/*/Makefile.am || die
	AT_NOELIBTOOLIZE=yes eautoreconf
}

src_configure() {
	local myeconfargs=( --docdir="${EPREFIX}/usr/share/doc/${PF}" )
	use arpack && myeconfargs+=( --with-arpack="${EPREFIX}/usr/$(get_libdir)" )

	# check which mpi version is installed and tell configure
	if use mpi; then
		export CC="${EPREFIX}/usr/bin/mpicc"
		export F77="${EPREFIX}/usr/bin/mpif77"

		if has_version sys-cluster/mpich; then
	 		myeconfargs+=( --with-mpich="${EPREFIX}/usr" )
		elif has_version sys-cluster/mpich2; then
			myeconfargs+=( --with-mpich2="${EPREFIX}/usr" )
		elif has_version sys-cluster/openmpi; then
			myeconfargs+=( --with-openmpi="${EPREFIX}/usr" )
		fi
	fi || die "Failed to select proper mpi implementation"

	if use fetk; then
		myeconfargs+=( --with-fetk-include="${EPREFIX}/usr/include" --with-fetk-library="${EPREFIX}/usr/$(get_libdir)" )
	else
		myeconfargs+=( --disable-fetk )
	fi

	[[ -n ${MAXMEM} ]] && myeconfargs+=( --with-maxmem=${MAXMEM} )

	if use python; then
		myeconfargs+=( --enable-tools  )
	else
		myeconfargs+=( $(use_enable tools) )
	fi

	myeconfargs+=(
		--disable-maloc-rebuild
		--enable-shared
		$(use_enable openmp)
		$(use_enable python)
		)
	autotools-utils_src_configure
}

src_test() {
	export LC_NUMERIC=C
	cd examples && make test \
		|| die "Tests failed"
	grep -q 'FAILED' "${S}"/examples/TESTRESULTS.log && die "Tests failed"
}

src_install() {
	autotools-utils_src_install

	use doc && dohtml -r doc/*
	use examples && insinto /usr/share/${PN} && doins -r examples
	use tools && emake DESTDIR="${D}" install-tools

	if use python && ! use mpi; then
		insinto $(python_get_sitedir)/${PN}
		doins tools/manip/*.py
		doins tools/python/{*.py,*.pqr}
		doins tools/python/*/{*.py,*.so}
		python_clean_installation_image
	fi

	if use python || use tools; then
		mv "${ED}"/usr/bin/analysis{,_apbs} || die
		mv "${ED}"/usr/bin/smooth{,_apbs} || die
	fi
}

pkg_postinst() {
	use python && python_mod_optimize ${PN}
	if use python || use tools; then
		echo
		elog "Following apps have been renamed"
		elog "${EPREFIX}/usr/bin/analysis -> ${EPREFIX}/usr/bin/analysis_apbs"
		elog "${EPREFIX}/usr/bin/smooth -> ${EPREFIX}/usr/bin/smooth_apbs"
		echo
	fi
}

pkg_postrm() {
	use python && python_mod_cleanup ${PN}
}
