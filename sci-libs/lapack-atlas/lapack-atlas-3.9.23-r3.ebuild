# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/lapack-atlas/lapack-atlas-3.9.23-r3.ebuild,v 1.8 2012/10/18 21:02:51 jlec Exp $

EAPI="3"

inherit eutils flag-o-matic fortran-2 toolchain-funcs autotools versionator

MY_PN="${PN/lapack-/}"
PATCH_V="3.9.21"
L_PN="lapack"
L_PV="3.1.1"
BlasRelease=$(get_version_component_range 1-3)

DESCRIPTION="F77 and C LAPACK implementations using available ATLAS routines"
HOMEPAGE="http://math-atlas.sourceforge.net/"
SRC_URI1="mirror://sourceforge/math-atlas/${MY_PN}${PV}.tar.bz2"
SRC_URI2="http://www.netlib.org/${L_PN}/${L_PN}-lite-${L_PV}.tgz"
SRC_URI="${SRC_URI1} ${SRC_URI2}
	mirror://gentoo/${MY_PN}-${PATCH_V}-shared-libs.2.patch.bz2
	mirror://gentoo/${L_PN}-reference-${L_PV}-autotools.patch.bz2"

SLOT="0"
LICENSE="BSD"
IUSE="doc"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"

CDEPEND="
	virtual/blas
	virtual/cblas
	app-admin/eselect-lapack
	~sci-libs/blas-atlas-${BlasRelease}"
DEPEND="${CDEPEND}
	virtual/pkgconfig
	>=sys-devel/libtool-1.5"
RDEPEND="${CDEPEND}
	doc? ( app-doc/lapack-docs )"

S="${WORKDIR}/ATLAS"
S_LAPACK="${WORKDIR}/${L_PN}-lite-${L_PV}"
BLD_DIR="${S}/gentoo-build"
RPATH="/usr/$(get_libdir)/${L_PN}/${MY_PN}"
S_LAPACK="${WORKDIR}"/${L_PN}-lite-${L_PV}

src_prepare() {
	epatch \
		"${DISTDIR}"/${MY_PN}-${PATCH_V}-shared-libs.2.patch.bz2 \
		"${FILESDIR}"/${MY_PN}-asm-gentoo.patch \
		"${FILESDIR}"/${PN}-${PATCH_V}-lam.patch

	# make sure the compile picks up the proper includes
	sed -i \
		-e "s|INCLUDES.*=|INCLUDES = -I${EPREFIX}/usr/include/atlas/|"  \
		"${S}"/CONFIG/src/SpewMakeInc.c \
		|| die "failed to append proper includes"

	cp "${FILESDIR}"/eselect.lapack.atlas "${T}"/
	sed -i -e "s:/usr:${EPREFIX}/usr:" \
		"${T}"/eselect.lapack.atlas || die
	if [[ ${CHOST} == *-darwin* ]] ; then
		sed -i -e 's/\.so\([\.0-9]\+\)\?/\1.dylib/g' \
			"${T}"/eselect.lapack.atlas || die
		sed -e /LIBTOOL/s/libtool/glibtool/ -i CONFIG/src/SpewMakeInc.c
		epatch "${FILESDIR}"/${PN}-3.9.3-darwin-make-top.patch
	fi

	mkdir "${BLD_DIR}" || die "failed to generate build directory"
	cd "${BLD_DIR}"
	cp "${FILESDIR}"/war . && chmod a+x war || die "failed to install war"
	sed -i -e '1c\#! '"${EPREFIX}"'/bin/bash' war
	cd "${S_LAPACK}"
	epatch "${WORKDIR}"/${L_PN}-reference-${L_PV}-autotools.patch
	epatch "${FILESDIR}"/${L_PN}-reference-${L_PV}-test-fix.patch
	eautoreconf
}

src_configure() {
	BLAS_LIBS="$(pkg-config --libs blas cblas)"

	cd "${BLD_DIR}"
	local archselect=
	if use amd64 || use ppc64; then
		archselect="-b 64"
	elif use alpha; then
		archselect=""
	else
		archselect="-b 32"
	fi

	# Remove -m64 on alpha, since the compiler doesn't support it
	use alpha && sed -i -e 's/-m64//g' "${S}"/CONFIG/src/probe_comp.c

	# unfortunately, atlas-3.9.0 chokes when passed
	# x86_64-pc-linux-gnu-gcc and friends instead of
	# plain gcc. Hence, we'll have to workaround this
	# until it is fixed by upstream
	local c_compiler=$(tc-getCC)
	if [[ "${c_compiler}" == *gcc* ]]; then
		c_compiler="gcc"
	fi

	../configure \
		--cc="${c_compiler}" \
		--cflags="${CFLAGS}" \
		--prefix="${ED}"/usr \
		--libdir="${ED}"/usr/$(get_libdir)/atlas \
		--incdir="${ED}"/usr/include \
		-C ac "${c_compiler}" -F ac "${CFLAGS}" \
		-C if $(tc-getFC) -F if "${FFLAGS:-'-O2'}" \
		-Ss pmake "\$(MAKE) ${MAKEOPTS}" \
		-Si cputhrchk 0 ${archselect} \
		|| die "configure failed"

	cd "${S_LAPACK}"
	# set up the testing routines
	sed -e "s:g77:$(tc-getFC):" \
		-e "s:-funroll-all-loops -O3:${FFLAGS} ${BLAS_LIBS}:" \
		-e "s:LOADOPTS =:LOADOPTS = ${LDFLAGS} ${BLAS_LIBS}:" \
		-e "s:../../blas\$(PLAT).a:${BLAS_LIBS}:" \
		-e "s:lapack\$(PLAT).a:SRC/.libs/liblapack.so -Wl,-rpath,${S_LAPACK}/SRC/.libs:" \
		-e "s:EXT_ETIME$:INT_CPU_TIME:" \
		make.inc.example > make.inc \
		|| die "Failed to set up make.inc"
	cd "${S_LAPACK}"
	econf
}

src_compile() {
	# build atlas' part of lapack
	cd "${BLD_DIR}"
	for d in src/lapack interfaces/lapack/C/src interfaces/lapack/F77/src interfaces/lapack/C2F/src; do
		cd "${BLD_DIR}"/${d}
		make lib || die "Failed to make lib in ${d}"
	done

	cd "${S_LAPACK}"
	emake || die "Failed to make reference lapack lib"

	cd "${S_LAPACK}"/SRC
	einfo "Copying liblapack.a/*.o to ${S_LAPACK}/SRC"
	cp -sf "${BLD_DIR}"/gentoo/liblapack.a/*.o .
	einfo "Copying liblapack.a/*.lo to ${S_LAPACK}/SRC"
	cp -sf "${BLD_DIR}"/gentoo/liblapack.a/*.lo .
	einfo "Copying liblapack.a/.libs/*.o to ${S_LAPACK}/SRC"
	cp -sf "${BLD_DIR}"/gentoo/liblapack.a/.libs/*.o .libs/

	local flibs
	[[ $(tc-getFC) =~ gfortran ]] && flibs=-lgfortran
	[[ $(tc-getFC) =~ g77 ]] && flibs=-lg2c
	../libtool --mode=link --tag=F77 $(tc-getFC) ${LDFLAGS} \
	"${BLAS_LIBS}" -latlas ${flibs} \
	-o "${S_LAPACK}"/SRC/liblapack.la *.lo -rpath "${EPREFIX}/${RPATH}" \
		|| die "Failed to create liblapack.la"

	# making pkg-config file
	sed -e "s:@LIBDIR@:$(get_libdir)/lapack/atlas:" \
		-e "s:=/usr:=${EPREFIX}/usr:" \
		-e "s:@PV@:${PV}:" \
		-e "s:@EXTLIBS@:-lm ${flibs}:g" \
		"${FILESDIR}"/lapack.pc.in > "${S}"/lapack.pc \
		|| die "sed lapack.pc failed"
}

src_install () {
	dodir "${RPATH}"

	cd "${S_LAPACK}"/SRC
	../libtool --mode=install cp liblapack.la "${ED}/${RPATH}" \
		|| die "Failed to install lapack-atlas library"

	ESELECT_PROF=atlas
	eselect lapack add $(get_libdir) "${T}"/eselect.lapack.atlas ${ESELECT_PROF}

	insinto /usr/include/atlas
	doins "${S}"/include/clapack.h || die "Failed to install clapack.h"
	dosym atlas/clapack.h /usr/include/clapack.h

	cd "${S}"
	dodoc README doc/AtlasCredits.txt doc/ChangeLog \
		|| die "Failed to install docs"

	insinto /usr/$(get_libdir)/lapack/atlas
	doins "${S}"/lapack.pc || die "Failed to install lapack.pc"
}

src_test() {
	cd "${S_LAPACK}"/TESTING/MATGEN
	emake || die "Failed to create tmglib.a"
	cd ..
	emake || die "lapack-reference tests failed"
}

pkg_postinst() {
	local current_lib=$(eselect lapack show | cut -d' ' -f2)
	# this snippet works around the eselect bug #189942 and makes
	# sure that users upgrading from a previous lapack-atlas
	# version pick up the new pkg-config files
	if [[ ${current_lib} == ${ESELECT_PROF} || -z ${current_lib} ]]; then
		local configfile="${EROOT}"/etc/env.d/lapack/$(get_libdir)/config
		[[ -e ${configfile} ]] && rm -f ${configfile}
		eselect lapack set ${ESELECT_PROF}
		elog "lapack has been eselected to ${ESELECT_PROF}"
	else
		elog "Current eselected lapack is ${current_lib}"
		elog "To use blas ${ESELECT_PROF} implementation, you have to issue (as root):"
		elog "\t eselect lapack set ${ESELECT_PROF}"
	fi
}
