# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/netcdf/netcdf-4.1.1-r4.ebuild,v 1.19 2012/10/16 20:31:51 jlec Exp $

EAPI=3

AUTOTOOLS_AUTORECONF=true
FORTRAN_NEEDED=fortran

inherit autotools-utils fortran-2

DESCRIPTION="Scientific library and interface for array oriented data access"
HOMEPAGE="http://www.unidata.ucar.edu/software/netcdf/"
SRC_URI="ftp://ftp.unidata.ucar.edu/pub/netcdf/${P}.tar.gz"

LICENSE="UCAR-Unidata"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris"
IUSE="cxx dap doc fortran hdf5 static-libs szip"

RDEPEND="
	dap? ( net-misc/curl )
	hdf5? ( >=sci-libs/hdf5-1.8[zlib,szip?,fortran?] )"

DEPEND="${RDEPEND}
	>=sys-devel/libtool-2.2
	doc? ( virtual/latex-base )
	fortran? ( dev-lang/cfortran )"

DOCS=(README RELEASE_NOTES)

PATCHES=(
	"${FILESDIR}"/${P}-parallel-build.patch
	"${FILESDIR}"/${P}-implicits.patch
	"${FILESDIR}"/${P}-mpi-fix.patch
	"${FILESDIR}"/${P}-fortran.patch
)

pkg_setup() {
	fortran-2_pkg_setup
	if use hdf5 && has_version sci-libs/hdf5[mpi]; then
		export CC=mpicc
		if use cxx; then
			export CXX=mpicxx
		fi
		if use fortran; then
			export FC=mpif90
			export F77=mpif77
		fi
	fi
}

src_prepare() {
	# use system cfortran
	rm -f fortran/cfortran.h || die
	# we don't build udunits and libcf
	sed -i -e '/udunits libcf/d' configure.ac || die
	if ! use doc; then
		sed -i -e "/\$(NC_TEST4)/ s/man4//" Makefile.am || die
	fi
	autotools-utils_src_prepare
}

src_configure() {
	local myconf
	if use hdf5; then
		myconf="--with-hdf5=${EPREFIX}/usr --with-zlib=${EPREFIX}/usr"
		use szip && myconf="${myconf} --with-szlib=${EPREFIX}/usr"
	fi

	myeconfargs=(
		--enable-shared
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
		$(use_enable dap)
		$(use_enable static-libs static)
		$(use_enable fortran f77)
		$(use_enable fortran f90)
		$(use_enable cxx)
		$(use_enable fortran separate-fortran)
		$(use_enable hdf5 netcdf-4)
		${myconf}
	)
	autotools-utils_src_configure
}

src_compile() {
	# hack to allow parallel build
	if use doc; then
		autotools-utils_src_compile pdf
		autotools-utils_src_compile -j1 -C man4
	fi
	autotools-utils_src_compile
}
