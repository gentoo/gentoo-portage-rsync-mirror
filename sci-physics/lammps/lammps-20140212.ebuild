# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/lammps/lammps-20140212.ebuild,v 1.2 2014/02/15 02:01:57 ottxor Exp $

EAPI=5

FORTRAN_NEEDED="lammps-package-meam"

inherit eutils fortran-2

convert_month() {
	case $1 in
		01) echo Jan
			;;
		02) echo Feb
			;;
		03) echo Mar
			;;
		04) echo Apr
			;;
		05) echo May
			;;
		06) echo Jun
			;;
		07) echo Jul
			;;
		08) echo Aug
			;;
		09) echo Sep
			;;
		10) echo Oct
			;;
		11) echo Nov
			;;
		12) echo Dec
			;;
		*)  echo unknown
			;;
	esac
}

MY_P=${PN}-$((10#${PV:6:2}))$(convert_month ${PV:4:2})${PV:2:2}

DESCRIPTION="Large-scale Atomic/Molecular Massively Parallel Simulator"
HOMEPAGE="http://lammps.sandia.gov/"
SRC_URI="http://lammps.sandia.gov/tars/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc examples gzip lammps-memalign lammps-package-dipole
	lammps-package-meam lammps-package-reax lammps-package-rigid mpi"

DEPEND="mpi? ( virtual/mpi )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

lmp_emake() {
	local LAMMPS_INCLUDEFLAGS
	LAMMPS_INCLUDEFLAGS="$(usex gzip '-DLAMMPS_GZIP' '')"
	LAMMPS_INCLUDEFLAGS+="$(usex lammps-memalign ' -DLAMMPS_MEMALIGN' '')"

	# The lammps makefile uses CC to indicate the C++ compiler.
	emake \
		ARCHIVE=$(tc-getAR) \
		CC=$(usex mpi "mpic++" "$(tc-getCXX)") \
		F90=$(usex mpi "mpif90" "$(tc-getFC)") \
		LINK=$(usex mpi "mpic++" "$(tc-getCXX)") \
		CCFLAGS="${CXXFLAGS}" \
		F90FLAGS="${FCFLAGS}" \
		LINKFLAGS="${LDFLAGS}" \
		LMP_INC="${LAMMPS_INCLUDEFLAGS}" \
		MPI_INC=$(usex mpi '' "-I../STUBS") \
		MPI_PATH=$(usex mpi '' '-L../STUBS') \
		MPI_LIB=$(usex mpi '' '-lmpi_stubs') \
		"$@"
}

src_prepare() {
	# Fix inconsistent use of SHFLAGS.
	sed -i -e 's:$(CCFLAGS):$(CCFLAGS) -fPIC:' src/STUBS/Makefile || die
	use !lammps-package-meam || sed -i -e 's:$(F90FLAGS):$(F90FLAGS) -fPIC:' lib/meam/Makefile.gfortran || die
	use !lammps-package-reax || sed -i -e 's:$(F90FLAGS):$(F90FLAGS) -fPIC:' lib/reax/Makefile.gfortran || die
}

src_compile() {
	# Compile stubs for serial version.
	use mpi || lmp_emake -C src stubs

	# Build optional packages.
	if use lammps-package-meam; then
		lmp_emake -C src yes-meam
		lmp_emake -j1 -C lib/meam -f Makefile.gfortran
	fi
	use lammps-package-dipole && emake -C src yes-dipole
	use lammps-package-rigid && emake -C src yes-rigid
	if use lammps-package-reax; then
		emake -C src yes-reax
		lmp_emake -j1 -C lib/reax -f Makefile.gfortran
	fi

	# Build static library.
	lmp_emake -C src makelib
	lmp_emake -C src -f Makefile.lib serial

	# Build shared library.
	lmp_emake -C src makeshlib
	lmp_emake -C src -f Makefile.shlib serial

	# Compile main executable.
	lmp_emake -C src serial
}

src_install() {
	newlib.a "src/liblammps_serial.a" "liblammps.a"
	newlib.so "src/liblammps_serial.so" "liblammps.so"
	newbin "src/lmp_serial" "lmp"

	local LAMMPS_POTENTIALS="/usr/share/${PF}/potentials"
	insinto "${LAMMPS_POTENTIALS}"
	doins potentials/*
	echo "LAMMPS_POTENTIALS=${LAMMPS_POTENTIALS}" > 99lammps
	doenvd 99lammps

	if use examples; then
		local LAMMPS_EXAMPLES="/usr/share/${PF}/examples"
		insinto "${LAMMPS_EXAMPLES}"
		doins -r examples/*
	fi

	dodoc README
	if use doc; then
		dodoc doc/Manual.pdf
		dohtml -r doc/*
	fi

	einfo "starting with this version, the optional package USE flags have"
	einfo "changed names. Simply prepend lammps- in front the old ones, i.e."
	einfo "the dipole package is built with the lammps-package-dipole USE"
	einfo "flag."
}
