# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/eden/eden-5.3-r1.ebuild,v 1.6 2012/07/26 14:20:18 jlec Exp $

EAPI=4

PYTHON_DEPEND="2"

inherit eutils multilib python toolchain-funcs

MY_P="${PN}_V${PV}"

DESCRIPTION="A crystallographic real-space electron-density refinement and optimization program"
HOMEPAGE="http://www.gromacs.org/pipermail/eden-users/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="double-precision"

RDEPEND="
	sci-libs/fftw:2.1
	sci-libs/gsl"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${PN}"

SRC="${S}/source"
EDENHOME="${EPREFIX}/usr/$(get_libdir)/eden"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${PV}-makefile-fixes.patch \
		"${FILESDIR}"/${P}-impl-dec.patch

	sed -i \
		-e "s:^\(FFTW.*=\).*:\1 ${EPREFIX}/usr:g" \
		-e "s:^\(LIB.*=.*\$(FFTW)/\).*:\1$(get_libdir):g" \
		-e "s:^\(BIN.*=\).*:\1 ${D}usr/bin:g" \
		-e "s:^\(CFLAGS.*=\).*:\1 ${CFLAGS}:g" \
		-e "s:-lgsl -lgslcblas:$(pkg-config --libs gsl):g" \
		${SRC}/Makefile || die

	if ! use double-precision; then
		sed -i -e "s:^\(DOUBLESWITCH.*=\).*:\1 OFF:g" ${SRC}/Makefile || die
		EXE="seden"
	else
		EXE="deden"
	fi
}

src_compile() {
	emake CC=$(tc-getCC) -C ${SRC}
}

src_install() {
	emake -C ${SRC} install

	exeinto ${EDENHOME}/python
	doexe python/*

	insinto ${EDENHOME}/help
	doins help/*

	insinto ${EDENHOME}/tools
	doins tools/*

	dodoc manual/UserManual.pdf

	cat >> "${T}"/eden <<- EOF
	#!/bin/bash
	export EDENHOME="${EDENHOME}"
	${EXE} \$*
	EOF

	dobin "${T}"/eden

	cat >> "${T}"/ieden <<- EOF
	#!/bin/bash
	export EDENHOME="${EDENHOME}"
	$(PYTHON) -O \${EDENHOME}/python/eden.py
	EOF

	dobin "${T}"/ieden
}

pkg_postinst() {
	python_mod_optimize ${EDENHOME}/python
}

pkg_postrm() {
	python_mod_cleanup ${EDENHOME}/python
}
