# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/fftw/fftw-3.3.3-r1.ebuild,v 1.5 2013/06/27 14:30:29 aballier Exp $

EAPI=5

#AUTOTOOLS_AUTORECONF=1
FORTRAN_NEEDED=fortran

inherit autotools-multilib eutils flag-o-matic fortran-2 toolchain-funcs versionator

DESCRIPTION="Fast C library for the Discrete Fourier Transform"
HOMEPAGE="http://www.fftw.org/"
SRC_URI="http://www.fftw.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="3.0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="altivec avx doc fma fortran mpi neon openmp quad sse sse2 static-libs test threads zbus"

# there is no abi_x86_32 port of virtual/mpi right now
REQUIRED_USE="amd64? ( abi_x86_32? ( !mpi !quad ) )"

RDEPEND="mpi? ( virtual/mpi )
	abi_x86_32? ( !<=app-emulation/emul-linux-x86-soundlibs-20130224-r2
					!app-emulation/emul-linux-x86-soundlibs[-abi_x86_32(-)] )"
DEPEND="${RDEPEND}
	test? ( dev-lang/perl )"

pkg_setup() {
	if use openmp; then
		if [[ $(tc-getCC) == *gcc ]] && ! tc-has-openmp; then
			ewarn "OpenMP is not available in your current selected gcc"
			die "need openmp capable gcc"
		fi
		FORTRAN_NEED_OPENMP=1
	fi
	fortran-2_pkg_setup
	FFTW_DIRS="single double longdouble"
	if use quad; then
		if [[ $(tc-getCC) == *gcc ]] && ! version_is_at_least 4.6 $(gcc-version); then
			ewarn "quad precision only available for gcc >= 4.6"
			die "need quad precision capable gcc"
		fi
		FFTW_DIRS+=" quad"
	fi
}

src_prepare() {
	# fix info file for category directory
	sed -i \
		-e 's/Texinfo documentation system/Libraries/' \
		doc/fftw3.info || die "failed to fix info file"

	autotools-utils_src_prepare
}

src_configure() {
	local x

	# filter -Os according to docs
	replace-flags -Os -O2

	for x in ${FFTW_DIRS}; do
		myeconfargs=(
			$(use_enable fma)
			$(use_enable fortran)
			$(use_enable zbus mips-zbus-timer)
			$(use_enable threads)
			$(use_enable openmp)
		)
		if [[ $x == single ]]; then
			#altivec, sse, single-paired only work for single
			myeconfargs+=(
				--enable-single
				$(use_enable altivec)
				$(use_enable avx)
				$(use_enable sse)
				$(use_enable mpi)
				$(use_enable neon)
			)
		elif [[ $x == double ]]; then
			myeconfargs+=(
				$(use_enable avx)
				$(use_enable sse2)
				$(use_enable mpi)
			)
		elif [[ $x == longdouble ]]; then
			myeconfargs+=(
				--enable-long-double
				$(use_enable mpi)
				)
		elif [[ $x == quad ]]; then
			#quad does not support mpi
			myeconfargs+=( --enable-quad-precision )
		else
			die "${x} precision not implemented in this ebuild"
		fi

		einfo "Configuring for ${x} precision"
		BUILD_DIR="${S}-${x}" \
			autotools-multilib_src_configure
	done
}

src_compile() {
	for x in ${FFTW_DIRS}; do
		einfo "Compiling for ${x} precision"
		BUILD_DIR="${S}-${x}" \
			autotools-multilib_src_compile
	done
}

src_test () {
	do_smalltest() { cd "${BUILD_DIR}" && emake -C tests smallcheck; }
	# We want this to be a reasonably quick test, but that is still hard...
	ewarn "This test series will take 30 minutes on a modern 2.5Ghz machine"
	# Do not increase the number of threads, it will not help your performance
	#local testbase="perl check.pl --nthreads=1 --estimate"
	#		${testbase} -${p}d || die "Failure: $n"
	for x in ${FFTW_DIRS}; do
		einfo "Testing ${x} precision"
		BUILD_DIR="${S}-${x}" \
			multilib_foreach_abi do_smalltest
	done
}

src_install () {
	local u x
	DOCS=( AUTHORS ChangeLog NEWS README TODO COPYRIGHT CONVENTIONS )
	HTML_DOCS=( doc/html/ )
	for x in ${FFTW_DIRS}; do
		BUILD_DIR="${S}-${x}" \
			autotools-multilib_src_install
	done

	if use doc; then
		dodoc doc/*.pdf
		insinto /usr/share/doc/${PF}/faq
		doins -r doc/FAQ/fftw-faq.html/*
	else
		rm -r "${ED}"/usr/share/doc/${PF}/html
	fi

	for x in "${ED}"/usr/lib*/pkgconfig/*.pc; do
		for u in $(usev mpi) $(usev threads) $(usex openmp omp ""); do
			sed -e "s|-lfftw3[flq]\?|&_$u &|" "$x" > "${x%.pc}_$u.pc" || die
		done
	done
}
