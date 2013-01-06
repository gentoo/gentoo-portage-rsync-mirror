# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/cyana/cyana-2.1.ebuild,v 1.10 2012/10/19 09:45:27 jlec Exp $

EAPI=4

inherit eutils fortran-2 toolchain-funcs

DESCRIPTION="Combined assignment and dynamics algorithm for NMR applications"
HOMEPAGE="http://www.las.jp/english/products/s08_cyana/index.html"
SRC_URI="${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="examples"

RESTRICT="fetch"

# we need libg2c for gfortran # 136988
DEPEND="dev-lang/ifc"
RDEPEND="${DEPEND}"

pkg_nofetch() {
	elog "Please visit"
	elog "http://www.las.jp/english/products/s08_cyana/licenses.html"
	elog "and get a copy of ${A}."
	elog "Place it in ${DISTDIR}."
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${PV}-typo.patch \
		"${FILESDIR}"/${PV}-exec.patch \
		"${FILESDIR}"/${PV}-expire.patch \
		"${FILESDIR}"/${PV}-xiar.patch

	cat >> etc/config <<- EOF
	VERSION=${PV}
	SHELL=${EPREFIX}/bin/sh
	FC=ifort
	FFLAGS=${FFLAGS} -openmp -threads
	FFLAGS2=${FFLAGS} -openmp -threads
	CC=$(tc-getCC)
	AR=xiar
	RANLIB=ranlib
	FORK=g77fork.o
	LDFLAGS=${LDFLAGS} -reentrancy threaded -openmp
	LIBS=
	EOF

	if [[ $(tc-getFC) =~ gfortran ]]; then
		cat >> etc/config <<- EOF
		DEFS=-Dgfortran
		SYSTEM=gfortran
		EOF
	else
		cat >> etc/config <<- EOF
		DEFS=-Dintel
		SYSTEM=intel
		EOF
	fi
}

src_compile() {
	cd src
	emake
}

src_install() {
	dobin cyana{job,table,filter,clean}
	newbin src/${PN}/${PN}exe.* ${PN}
	insinto /usr/share/${PN}
	doins -r lib macro help
	use examples && doins -r demo

	cat >> "${T}"/20cyana <<- EOF
	CYANALIB="${EPREFIX}/usr/share/${PN}"
	EOF

	doenvd "${T}"/20cyana
}
