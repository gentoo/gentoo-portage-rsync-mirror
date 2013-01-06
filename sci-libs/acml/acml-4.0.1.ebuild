# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/acml/acml-4.0.1.ebuild,v 1.10 2012/10/16 20:48:56 jlec Exp $

inherit eutils fortran-2 multilib toolchain-funcs

MY_PV=${PV//\./\-}

DESCRIPTION="AMD Core Math Library (ACML) for x86_64 CPUs"
HOMEPAGE="http://developer.amd.com/acml.jsp"
SRC_URI="
	ifc? ( acml-${MY_PV}-ifort-64bit.tgz )
	!ifc? (
		int64? ( acml-${MY_PV}-gfortran-64bit-int64.tgz )
		!int64? ( acml-${MY_PV}-gfortran-64bit.tgz )
		)"

SLOT="0"
LICENSE="ACML"
KEYWORDS="~amd64"
IUSE="openmp ifc int64 doc examples"

RESTRICT="strip fetch"

DEPEND="
	ifc? ( dev-lang/ifc )
	app-admin/eselect-blas
	app-admin/eselect-lapack"
RDEPEND="${DEPEND}
	doc? ( app-doc/blas-docs app-doc/lapack-docs )"

S="${WORKDIR}"

pkg_nofetch() {
	einfo "Please download the ACML from:"
	einfo "${HOMEPAGE}"
	einfo "and place it in ${DISTDIR}."
	einfo "The previous versions could be found at"
	einfo "http://developer.amd.com/acmlarchive.jsp"
	einfo "SRC=${A} $SRC_URI"
}

get_fcomp() {
	case $(tc-getFC) in
		*gfortran* )
			FCOMP="gfortran" ;;
		ifort )
			FCOMP="ifc" ;;
		* )
			FCOMP=$(tc-getFC) ;;
	esac
}

pkg_setup() {
	if [[ $(tc-getFC) =~ gfortran ]]; then
		local gcc_version=$(gcc-major-version)$(gcc-minor-version)
		if ! use openmp && (( ${gcc_version} != 41 )); then
			eerror "You need gcc-4.1.x to test acml."
			eerror "Please use gcc-config to swicth gcc version 4.1.x"
			die "setup gcc failed"
		fi
	fi
	if use openmp; then
		tc-has-openmp || die "Please ensure your compiler has openmp support"
		FORTRAN_NEED_OPENMP=1
	fi
	fortran-2_pkg_setup
	get_fcomp
}

src_unpack() {
	unpack ${A}
	(DISTDIR="${S}" unpack contents-acml-*.tgz)
	case ${FCOMP} in
		gfortran) FORT=gfortran ;;
		if*) FORT=ifort ;;
		*) eerror "Unsupported fortran compiler: $(tc-getFC)"
		   die "failed configuring fortran";;
	esac
	use openmp || rm -rf ${FORT}*_mp*
	FORTDIRS="$(ls -d ${FORT}*)"
}

src_test() {
	local forts=${FORTDIRS}
	# only testing with current compiler
	use openmp && forts="$(ls -d ${FORT}*_mp*)"
	for fort in ${forts}; do
		einfo "Testing acml for ${fort}"
		cd "${S}"/${fort}/examples
		for d in . acml_mv; do
			cd "${S}"/${fort}/examples/${d}
			emake \
				ACMLDIR="${S}"/${fort} \
				F77=$(tc-getFC) \
				CC="$(tc-getCC)" \
				CPLUSPLUS="$(tc-getCXX)" \
				|| die "emake test in ${fort}/examples/${d} failed"
			emake clean
		done
	done
}

src_install() {
	# respect acml default install dir (and FHS)
	local instdir=/opt/${PN}${PV}
	dodir ${instdir}

	for fort in ${FORTDIRS}; do
		# install acml
		use examples || rm -rf "${S}"/${fort}/examples
		cp -pPR "${S}"/${fort} "${D}"${instdir} || die "copy ${fort} failed"

		# install profiles
		ESELECT_PROF=acml-${FCOMP}
		local acmldir=${instdir}/${fort}
		local acmllibs="-lacml -lacml_mv"
		local libname=${acmldir}/lib/libacml
		local extlibs=
		local extflags=
		if [[ ${fort} =~ int64 ]]; then
			ESELECT_PROF=${ESELECT_PROF}-int64
			extflags="${extflags} -fdefault-integer-8"
		fi
		[[ ${fort} =~ gfortran ]] && extlibs="${extlibs} -lgfortran"
		if [[ ${fort} =~ _mp ]]; then
			ESELECT_PROF=${ESELECT_PROF}-openmp
			extlibs="${extlibs} -lpthread"
			acmllibs="-lacml_mp -lacml_mv"
			libname=${libname}_mp
			extflags="${extflags} -fopenmp"
		fi
		for l in blas lapack; do
			# pkgconfig files
			sed -e "s:@LIBDIR@:$(get_libdir):" \
				-e "s:@PV@:${PV}:" \
				-e "s:@ACMLDIR@:${acmldir}:g" \
				-e "s:@ACMLLIBS@:${acmllibs}:g" \
				-e "s:@EXTLIBS@:${extlibs}:g" \
				-e "s:@EXTFLAGS@:${extflags}:g" \
				"${FILESDIR}"/${l}.pc.in > ${l}.pc \
				|| die "sed ${l}.pc failed"
			insinto ${acmldir}/lib
			doins ${l}.pc || die "doins ${l}.pc failed"

			# eselect files
			cat > eselect.${l} <<-EOF
				${libname}.so /usr/@LIBDIR@/lib${l}.so.0
				${libname}.so /usr/@LIBDIR@/lib${l}.so
				${libname}.a /usr/@LIBDIR@/lib${l}.a
				${acmldir}/lib/${l}.pc /usr/@LIBDIR@/pkgconfig/${l}.pc
			EOF
			eselect ${l} add $(get_libdir) eselect.${l} ${ESELECT_PROF}
		done
		echo "LDPATH=${instdir}/${fort}/lib" > 35acml
	done

	doenvd 35acml || die "doenvd failed"

	use doc || rm -rf "${S}"/Doc/acml.pdf "${S}"/Doc/html
	cp -pPR "${S}"/Doc "${D}"${instdir} || die "copy doc failed"
}

pkg_postinst() {
	for p in blas lapack; do
		local current_lib=$(eselect ${p} show | cut -d' ' -f2)
		if [[ ${current_lib} == ${ESELECT_PROF} || -z ${current_lib} ]]; then
		# work around eselect bug #189942
			local configfile="${ROOT}"/etc/env.d/${p}/$(get_libdir)/config
			[[ -e ${configfile} ]] && rm -f ${configfile}
			eselect ${p} set ${ESELECT_PROF}
			elog "${p} has been eselected to ${ESELECT_PROF}"
		else
			elog "Current eselected ${p} is ${current_lib}"
			elog "To use ${p} ${ESELECT_PROF} implementation, you have to issue (as root):"
			elog "\t eselect ${p} set ${ESELECT_PROF}"
		fi
	done
}
