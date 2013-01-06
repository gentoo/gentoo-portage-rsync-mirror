# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/refmac/refmac-5.5.0110-r2.ebuild,v 1.14 2012/10/19 10:25:51 jlec Exp $

EAPI=2

inherit base fortran-2 flag-o-matic toolchain-funcs versionator

DESCRIPTION="Macromolecular crystallographic refinement program"
HOMEPAGE="http://www.ysbl.york.ac.uk/~garib/refmac"
SRC_URI="
	${HOMEPAGE}/data/refmac_stable/refmac_${PV}.tar.gz
	test? ( http://dev.gentooexperimental.org/~jlec/distfiles/test-framework.tar.gz )"

SLOT="0"
LICENSE="ccp4"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="
	sci-chemistry/makecif
	>=sci-libs/ccp4-libs-6.1.3-r7
	sci-libs/mmdb
	<sci-libs/monomer-db-1
	virtual/blas
	virtual/lapack"
DEPEND="${RDEPEND}"

FORTRAN_STANDARD="77 90"

S="${WORKDIR}"

PATCHES=(
	"${FILESDIR}"/${PV}-allow-dynamic-linking.patch
	)

src_prepare() {
	base_src_prepare
	use test && epatch "${FILESDIR}"/$(get_version_component_range 1-2 ${PV})-test.log.patch
	[[ ${FC} == *gfortran* ]] && \
		append-fflags -fno-second-underscore && \
		append-cflags -DGFORTRAN -DPROTOTYPE && \
		append-libs -lgfortran -lgfortranbegin -lstdc++
	[[ ${FC} == *ifort* ]] && \
		append-libs -lstdc++
}

src_compile() {
	emake \
		FC=$(tc-getFC) \
		CC=$(tc-getCC) \
		CXX=$(tc-getCXX) \
		COPTIM="${CFLAGS}" \
		FOPTIM="${FFLAGS:- -O2}" \
		VERSION="" \
		XFFLAGS="" \
		XCFLAGS="" \
		LLIBCCP="-lccp4f -lccp4c -lccif $(pkg-config --libs mmdb)" \
		LLIBLAPACK="$(pkg-config --libs lapack blas)" \
		LLIBOTHERS="${LIBS}" \
		${PN} libcheck || die
}

src_test() {
	einfo "Starting tests ..."
	source "${EPREFIX}/etc/profile.d/40ccp4.setup.sh"
	export PATH="${WORKDIR}/test-framework/scripts:${S}:${PATH}"
	export CCP4_TEST="${WORKDIR}"/test-framework
	export CCP4_SCR="${T}"
	ln -sf refmac "${S}"/refmac5
	sed '/^ANISOU/d' -i ${CCP4_TEST}/data/pdb/1vr7.pdb
	ccp4-run-thorough-tests -v test_refmac5 || die
}

src_install() {
	exeinto /usr/libexec/ccp4/bin/
	doexe ${PN} || die
	dosym ../libexec/ccp4/bin/${PN} /usr/bin/${PN}
	dosym refmac /usr/bin/refmac5 || die
	dodoc refmac_keywords.pdf bugs_and_features.pdf || die
}
